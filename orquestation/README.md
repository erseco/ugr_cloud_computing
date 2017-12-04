# HOW-TO

Instalamos vagrant

az login

az ad sp create-for-rbac


az account list --query "[?isDefault].id" -o tsv

Creamos un vagrantfile

```
Vagrant.configure('2') do |config|
  config.vm.box = 'azure'

  # use local ssh key to connect to remote vagrant box
  config.ssh.private_key_path = '~/.ssh/id_rsa'
  config.vm.provider :azure do |azure, override|

    # each of the below values will default to use the env vars named as below if not specified explicitly
    azure.tenant_id = ENV['AZURE_TENANT_ID']
    azure.client_id = ENV['AZURE_CLIENT_ID']
    azure.client_secret = ENV['AZURE_CLIENT_SECRET']
    azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']
  end

end
```

vagrant box add azure https://github.com/azure/vagrant-azure/raw/v2.0/dummy.box --provider azure

vagrant plugin install vagrant-azure

vagrant up --provider=azure



➜  orquestation git:(master) ✗ vagrant ssh
==> default: The machine does not exist. Please run `vagrant up` first.
➜  orquestation git:(master) ✗ vagrant up
Bringing machine 'default' up with 'azure' provider...
==> default: Launching an instance with the following settings...
==> default:  -- Management Endpoint: https://management.azure.com
==> default:  -- Subscription Id: 103d06ad-2052-4f03-9762-f1873fc22968
==> default:  -- Resource Group Name: sparkling-sky-87
==> default:  -- Location: westus
==> default:  -- Admin Username: vagrant
==> default:  -- VM Name: frosty-field-52
==> default:  -- VM Storage Account Type: Premium_LRS
==> default:  -- VM Size: Standard_DS2_v2
==> default:  -- Image URN: canonical:ubuntuserver:16.04.0-LTS:latest
==> default:  -- DNS Label Prefix: frosty-field-52
==> default:  -- Create or Update of Resource Group: sparkling-sky-87
==> default:  -- Starting deployment
/Users/ernesto/.vagrant.d/gems/2.4.2/gems/ms_rest_azure-0.7.0/lib/ms_rest_azure/azure_service_client.rb:93:in `get_long_running_operation_result': { (MsRestAzure::AzureOperationError)
  "message": "Long running operation failed with status Failed",
  "request": {
    "base_uri": "https://management.azure.com",
    "path_template": "https://management.azure.com/subscriptions/103d06ad-2052-4f03-9762-f1873fc22968/resourcegroups/sparkling-sky-87/providers/Microsoft.Resources/deployments/vagrant_20171204110315/operationStatuses/08586892214870878580?api-version=2016-09-01",
    "method": "get",
    "path_params": null,
    "skip_encoding_path_params": null,
    "query_params": null,
    "skip_encoding_query_params": null,
    "headers": {
      "Content-Type": "application/json; charset=utf-8",
      "accept-language": "en-US",
      "x-ms-client-request-id": "633f165e-1581-4b56-bc35-da6f56f3214a"
    },
    "body": null,
    "middlewares": [
      [
        "MsRest::RetryPolicyMiddleware",
        {
          "times": 3,
          "retry": 0.02
        }
      ],
      [
        "cookie_jar"
      ]
    ],
    "log": null
  },
  "response": {
    "body": "{\"status\":\"Failed\",\"error\":{\"code\":\"DeploymentFailed\",\"message\":\"At least one resource deployment operation failed. Please list deployment operations for details. Please see https://aka.ms/arm-debug for usage details.\",\"details\":[{\"code\":\"Conflict\",\"message\":\"{\\r\\n  \\\"error\\\": {\\r\\n    \\\"code\\\": \\\"SkuNotAvailable\\\",\\r\\n    \\\"message\\\": \\\"The requested size for resource '/subscriptions/103d06ad-2052-4f03-9762-f1873fc22968/resourceGroups/sparkling-sky-87/providers/Microsoft.Compute/virtualMachines/frosty-field-52' is currently not available in location 'westus' zones '' for subscription '103d06ad-2052-4f03-9762-f1873fc22968'. Please try another size or deploy to a different location or zones. See https://aka.ms/azureskunotavailable for details.\\\"\\r\\n  }\\r\\n}\"}]}}",
    "headers": {
      "cache-control": "no-cache",
      "pragma": "no-cache",
      "content-type": "application/json; charset=utf-8",
      "expires": "-1",
      "vary": "Accept-Encoding",
      "x-ms-ratelimit-remaining-subscription-reads": "14998",
      "x-ms-request-id": "f5cb6736-e264-4af4-92e2-4a4abf8e6fe6",
      "x-ms-correlation-request-id": "f5cb6736-e264-4af4-92e2-4a4abf8e6fe6",
      "x-ms-routing-request-id": "UKWEST:20171204T110425Z:f5cb6736-e264-4af4-92e2-4a4abf8e6fe6",
      "strict-transport-security": "max-age=31536000; includeSubDomains",
      "date": "Mon, 04 Dec 2017 11:04:25 GMT",
      "connection": "close",
      "content-length": "581"
    },
    "status": 200
  }
}
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/azure_mgmt_resources-0.10.0/lib/generated/azure_mgmt_resources/deployments.rb:208:in `block in create_or_update_async'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/promise.rb:501:in `block in on_fulfill'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/executor/safe_task_executor.rb:24:in `block in execute'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/synchronization/mri_lockable_object.rb:38:in `block in synchronize'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/synchronization/mri_lockable_object.rb:38:in `synchronize'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/synchronization/mri_lockable_object.rb:38:in `synchronize'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/executor/safe_task_executor.rb:19:in `execute'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/promise.rb:531:in `block in realize'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/executor/ruby_thread_pool_executor.rb:348:in `run_task'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/executor/ruby_thread_pool_executor.rb:337:in `block (3 levels) in create_worker'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/executor/ruby_thread_pool_executor.rb:320:in `loop'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/executor/ruby_thread_pool_executor.rb:320:in `block (2 levels) in create_worker'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/executor/ruby_thread_pool_executor.rb:319:in `catch'
	from /Users/ernesto/.vagrant.d/gems/2.4.2/gems/concurrent-ruby-1.0.5/lib/concurrent/executor/ruby_thread_pool_executor.rb:319:in `block in create_worker'



