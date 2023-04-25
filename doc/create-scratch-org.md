## Create Scratch Org Instruction

1) Login to DevHub if not logged in. Use your own developer account. In this account must be enabled dev hub feature. For enable Dev Hub got to Setup > Dev Hub

    ```sh
    sfdx force:auth:web:login -d -a devHubAlias
    ```

   If you already logged in to devhub you can set this devhub as default with command:

    ```sh
    sfdx force:config:set defaultdevhubusername=devHubAlias
    ```

2) Create a Scratch Org

    ```sh
    sfdx force:org:create -f config/project-scratch-def.json -d 30 -s -a triggerFrameworkScratch
    ```

3) Push project to the Scratch Org

    ```sh
    sfdx force:source:push
    ```

4) Apply scratch org in the IDE (Idea or Webstorm)

    ```sh
    File > Settings > Languages and frameworks > Illuminate Cloud (...) > Select in conection column "YourScratchAlias"
    ```

