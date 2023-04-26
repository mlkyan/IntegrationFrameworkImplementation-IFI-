## Unlocked Packaging Commands

### 1 Create a Package

```sh
sfdx package:create --name integration-framework --description "Integration Framework Implementation (IFI)" --package-type Unlocked --path force-app --no-namespace --target-hub-org targetDevHub
```

### 2 Create a new version

```sh
sfdx package:version:create -p integration-framework -d force-app -k test1234 -w 10 -c -v targetDevHub
```

#### 2.1 Check code coverage:

```sh
sfdx force:package:version:report --package integration-framework@1.0.0-1 --verbose
```

### 3 Promote the version

```sh
sfdx package:version:promote -p integration-framework@1.0.0-1 -v targetDevHub```
