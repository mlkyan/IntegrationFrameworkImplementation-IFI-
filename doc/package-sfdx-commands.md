## Unlocked Packaging Commands

### 1 Create a Package

```sh
sfdx package:create -n your-lib-name -d "Lib description ..." -t Unlocked -r force-app/lib-dir --nonamespace -v targetDevHub
```

### 2 Create a new version

```sh
sfdx package:version:create -p your-lib-name -d force-app/lib-dir -k DgE6Gf9GzWd -w 10 -c -v targetDevHub
```

#### 2.1 Check code coverage:

```sh
sfdx force:package:version:report --package your-lib-name@1.0.0-1 --verbose
```

### 3 Promote the version

```sh
sfdx package:version:promote -p your-lib-name@1.0.0-1 -v targetDevHub
```
