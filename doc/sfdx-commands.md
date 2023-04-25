# Useful SFDX commands


#### 1) Login into the org

Prod/Dev:
```
sfdx force:auth:web:login -d -a orgAlias
```
Sandbox:
```
sfdx force:auth:web:login -d -a orgAlias -r https://test.salesforce.com
```



#### 2) Set default dev-hub or scratch org in the current folder or global (add key: --global)

Default Devhub:
```
sfdx force:config:set defaultdevhubusername=devHubAlias
```

Default scratch:
```
sfdx force:config:set defaultusername=scratchOrgAlias
```

Booth:
```
sfdx force:config:set defaultusername=scratchOrgAlias defaultdevhubusername=devHubAlias
```


#### 3) Create scratch org:
```
sfdx force:org:create -f config/project-scratch-def.json -d 30 -s -a sOrgAlias
```


#### 4) Open scratch org (for not default use: -u orgAlias)
```
sfdx force:org:open
```


#### 5) Retrieve metadata:
```
sfdx force:source:retrieve -x assets/package.xml -p unpackaged -u orgAlias -w 10
```


#### 6) Convert (metadata > dx format):
```
sfdx force:mdapi:convert --rootdir retrieve_tmp --outputdir dx-converted
```


#### 7) Convert (dx format > metadata ):
```
sfdx force:source:convert -d output
```


#### 8) push/pull:
```
sfdx force:source:pull
```
```
sfdx force:source:push
```


#### 9) Generate password:
Generate:
```
sfdx force:user:password:generate
```
Display credentials info:
```
sfdx force:user:display
```


#### 10) Update CI variable
```
sfdx force:auth:web:login -a sandBoxAlias -r https://test.salesforce.com
```
```
sfdx force:org:display -u sandBoxAlias --verbose
```

#### 11) Mark Scratch Org for deletion:
```
sfdx force:org:delete -u scratchOrgAlias
```

#### 12) Deploy zip file:
Create connections in
To Sandbox:
```
sfdx force:auth:web:login -d -a destOrgAliasSandbox -r https://test.salesforce.com
```
To Prod:
```
sfdx force:auth:web:login -d -a destOrgAliasProd
```
Test deploy:
```
sfdx force:mdapi:deploy --testlevel RunLocalTests --wait 60 --checkonly -u destOrgAlias --zipfile zipName
```
Real deploy:
```
sfdx force:mdapi:deploy --testlevel RunLocalTests --wait 60 -u destOrgAlias --zipfile zipName
```

#### 13) Export data as plan:
```
sfdx force:data:tree:export -p -q "SELECT Id, Title__c, (SELECT Id, Country__c FROM Product_Countries__r) FROM Content_Product__c" -d ./your_data_folder 
```


#### 14) Import data as plan:
```
sfdx force:data:tree:import -p ./your_data_folder/import-plan.json
```

#### 15) Create connection for INT scratch org. _Please remove this point after transition to sandbox_
````
sfdx auth:sfdxurl:store -f int-org.url
````