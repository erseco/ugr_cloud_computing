<?php

namespace OC;
use OCP\Events\EventEmitterTrait;

/**
 * This class is responsible for reading and writing config.php, the very basic
 * configuration file of ownCloud.
 */
class Config {

    use EventEmitterTrait;
    const ENV_PREFIX = 'OC_';

    /** @var array Associative array ($key => $value) */
    protected $cache = [];
    /** @var string */
    protected $configDir;
    /** @var string */
    protected $configFilePath;
    /** @var string */
    protected $configFileName;

    /**
     * @param string $configDir Path to the config dir, needs to end with '/'
     * @param string $fileName (Optional) Name of the config file. Defaults to config.php
     */
    public function __construct($configDir, $fileName = 'config.php') {
        $this->configDir = $configDir;
        $this->configFilePath = $this->configDir.$fileName;
        $this->configFileName = $fileName;
        $this->readData();
    }

    /**
     * Lists all available config keys
     *
     * Please note that it does not return the values.
     *
     * @return array an array of key names
     */
    public function getKeys() {
        return array_keys($this->cache);
    }

    /**
     * Returns a config value
     *
     * gets its value from an `OC_` prefixed environment variable
     * if it doesn't exist from config.php
     * if this doesn't exist either, it will return the given `$default`
     *
     * @param string $key key
     * @param mixed $default = null default value
     * @return mixed the value or $default
     */
    public function getValue($key, $default = null) {
        $envValue = getenv(self::ENV_PREFIX . $key);
        if ($envValue) {
            return $envValue;
        }

        if (isset($this->cache[$key])) {
            return $this->cache[$key];
        }

        return $default;
    }

    /**
     * Sets and deletes values and writes the config.php
     *
     * @param array $configs Associative array with `key => value` pairs
     *                       If value is null, the config key will be deleted
     */
    public function setValues(array $configs) {
        if ($this->isReadOnly()) {
            throw new \Exception('Config file is read only.');
        }
        $needsUpdate = false;
        foreach ($configs as $key => $value) {
            if ($value !== null) {
                $needsUpdate |= $this->set($key, $value);
            } else {
                $needsUpdate |= $this->delete($key);
            }
        }

        if ($needsUpdate) {
            // Write changes
            $this->writeData();
        }
    }

    /**
     * Sets the value and writes it to config.php if required
     *
     * @param string $key key
     * @param mixed $value value
     */
    public function setValue($key, $value) {
        /**
         * update and oldvalue help the after event listeners to know
         * if its an update or not. If update then get the old value.
         */
        $update = false;
        $oldValue = null;
        if ($this->isReadOnly()) {
            throw new \Exception('Config file is read only.');
        }

        if (isset($this->cache[$key])) {
            $update = true;
            $oldValue = $this->cache[$key];
        }

        $this->emittingCall(function () use (&$key, &$value) {
            if ($this->set($key, $value)) {
                // Write changes
                $this->writeData();
            }
            return true;
        }, [
            'before' => ['key' => $key, 'value' => $value],
            'after' => ['key' => $key, 'value' => $value, 'update' => $update, 'oldvalue' => $oldValue]
        ], 'config', 'setvalue');
    }

    /**
     * This function sets the value
     *
     * @param string $key key
     * @param mixed $value value
     * @return bool True if the file needs to be updated, false otherwise
     */
    protected function set($key, $value) {
        return $this->emittingCall(function (&$afterArray) use (&$key, &$value) {
            if (!isset($this->cache[$key]) || $this->cache[$key] !== $value) {
                if (isset($this->cache[$key])) {
                    $afterArray['update'] = true;
                    $afterArray['oldvalue'] = $this->cache[$key];
                }
                // Add change
                $this->cache[$key] = $value;
                return true;
            }

            return false;
        },[
            'before' => ['key' => $key, 'value' => $value],
            'after' => ['key' => $key, 'value' => $value, 'update' => false, 'oldvalue' => null]
        ], 'config', 'setvalue');
    }

    /**
     * Removes a key from the config and removes it from config.php if required
     * @param string $key
     */
    public function deleteKey($key) {
        if ($this->isReadOnly()) {
            throw new \Exception('Config file is read only.');
        }
        $this->emittingCall(function (&$afterArray) use (&$key) {
            if (isset($this->cache[$key])) {
                $afterArray['value'] = $this->cache[$key];
            }
            if ($this->delete($key)) {
                // Write changes
                $this->writeData();
            }
            return true;
        }, [
            'before' => ['key' => $key, 'value' => null],
            'after' => ['key' => $key, 'value' => null]
        ], 'config', 'deletevalue');
    }

    /**
     * This function removes a key from the config
     *
     * @param string $key
     * @return bool True if the file needs to be updated, false otherwise
     */
    protected function delete($key) {
        return $this->emittingCall(function (&$afterArray) use (&$key) {
            if (isset($this->cache[$key])) {
                $afterArray['value'] = $this->cache[$key];
                // Delete key from cache
                unset($this->cache[$key]);
                return true;
            }
            return false;
        }, [
            'before' => ['key' => $key, 'value' => null],
            'after' => ['key' => $key, 'value' => null]
        ], 'config', 'deletevalue');
    }

    /**
     * Loads the config file
     *
     * Reads the config file and saves it to the cache
     *
     * @throws \Exception If no lock could be acquired or the config file has not been found
     */
    private function readData() {
        // Default config should always get loaded
        $configFiles = [$this->configFilePath];

        // Add all files in the config dir ending with the same file name
        $extra = glob($this->configDir.'*.'.$this->configFileName);
        if (is_array($extra)) {
            natsort($extra);
            $configFiles = array_merge($configFiles, $extra);
        }

        // Include file and merge config
        foreach ($configFiles as $file) {
            $filePointer = file_exists($file) ? fopen($file, 'r') : false;
            if($file === $this->configFilePath &&
                $filePointer === false &&
                @!file_exists($this->configFilePath)) {
                // Opening the main config might not be possible, e.g. if the wrong
                // permissions are set (likely on a new installation)
                continue;
            }

            unset($CONFIG);
            include $file;
            if(isset($CONFIG) && is_array($CONFIG)) {
                $this->cache = array_merge($this->cache, $CONFIG);
            }

            // Close the file pointer and release the lock
            fclose($filePointer);
        }
    }

    /**
     * Writes the config file
     *
     * Saves the config to the config file.
     *
     * @throws HintException If the config file cannot be written to
     * @throws \Exception If no file lock can be acquired
     */
    private function writeData() {
        // Create a php file ...
        $content = "<?php\n";
        $content .= '$CONFIG = ';
        $content .= var_export($this->cache, true);
        $content .= ";\n";

        touch ($this->configFilePath);
        $filePointer = fopen($this->configFilePath, 'r+');

        // Prevent others not to read the config
        chmod($this->configFilePath, 0640);

        // File does not exist, this can happen when doing a fresh install
        if(!is_resource ($filePointer)) {
            // TODO fix this via DI once it is very clear that this doesn't cause side effects due to initialization order
            // currently this breaks app routes but also could have other side effects especially during setup and exception handling
            $url = \OC::$server->getURLGenerator()->linkToDocs('admin-dir_permissions');
            throw new HintException(
                "Can't write into config directory!",
                'This can usually be fixed by '
                .'<a href="' . $url . '" target="_blank" rel="noreferrer">giving the webserver write access to the config directory</a>.');
        }

        // Write the config and release the lock
        ftruncate ($filePointer, 0);
        fwrite($filePointer, $content);
        fflush($filePointer);
        fclose($filePointer);

        // Try invalidating the opcache just for the file we wrote...
        if (!\OC_Util::deleteFromOpcodeCache($this->configFilePath)) {
            // But if that doesn't work, clear the whole cache.
            \OC_Util::clearOpcodeCache();
        }
    }

    public function isReadOnly() {
        if (!$this->getValue('installed', false)) {
            return false;
        }
        if ($this->getValue('operation.mode', 'single-instance') !== 'single-instance') {
            return false;
        }

        return $this->getValue('config_is_read_only', false);
    }
}