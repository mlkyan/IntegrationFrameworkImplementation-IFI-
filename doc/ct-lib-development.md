# CT Lib Development

## Creating of the Project

1) Clone https://gitlab.customertimes.com/ct-libs/ct-lib-template.git into you local disc
2) Create empty folder with name of your module in your local disc. For example: /Users/work/IdeaProjects/CTLibs/MyNewLib
3) Copy files from ct-lib-template to the new project folder
4) Create local git repository in the new project folder
5) Create new project in CTLibs remote repository in Gitlab or ask your Dev Lead to do it.
6) Connect remote repository with local repository
7) Commit template structure to remote repository


## Starting of Development

1) Login to your own DevHub org. Turn on Dev Hub there

    ```
    sfdx force:auth:web:login -d -a DevHub
    ```

   or you can use already logged in Org, but you need to make it default with this command:

    ```
    sfdx force:config:set defaultdevhubusername=YourDevHubAlias
    ```

2) Run scratch org creation script (you can use another name of scratch instead "ScratchAlias"):
    ```
    ./create-scratch-org.sh ScratchAlias
    ```

3) Use scratch org for development


4) Test and commit changes to your local and remote repository

5) Update scratch org creation script create-scratch-org.sh if required 


## Creating package

1) See commands in [package-sfdx-commands.md](./doc/package-sfdx-commands.md)
2) Create package, it must be done once
3) Create version of package. do it every time you need to test package installation
4) Promote your package version. Promoting required to install package in Prod environment. Module must have code coverage > 75%. WARNING! Don't forget to update this file [package-info.txt](/doc/package-info.txt) with your password and package Id.
