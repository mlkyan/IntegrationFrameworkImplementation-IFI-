# Steps to release new CT Libs Package Version

1) For initial release of package create package with **CTlib1** user (ask dev lead for credentials) see [package-sfdx-commands.md](/doc/package-sfdx-commands.md)
2) Go to [sfdx-project.json](/sfdx-project.json) and increment major package version, don't forget to change in both fields (versionName and versionNumber) 

```
   "versionName": "Version 1.7",
   "versionNumber": "1.7.0.NEXT",
```

3) Create new version with SFDX command (see [package-sfdx-commands.md](/doc/package-sfdx-commands.md))
4) Promote new version with SFDX command (see [package-sfdx-commands.md](/doc/package-sfdx-commands.md))
5) Update [package-info.txt](/doc/package-info.txt) - change id of package to new one
6) Add feature description in [release-notes.md](/doc/release-notes.md) for your package version
7) Commit all changes to Git repository
8) Create tag in Git with name **Varsion_X.X** for example Version_1.7