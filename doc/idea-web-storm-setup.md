# IntelliJ Idea / Webstorm setup

1) Switch terminal to work with Git Bash
    ```
    File > Settings > Tools > Terminal >  Shell Path
    ```
    
    Select your path to GitBash/bin/bash.exe in terminal settings
    for example: C:\Program Files\Git\bin\bash.exe
   
2) Install Illuminated Cloud plugin

3) Set path to SFDX CLI:
    ```
    File > Settings > Languages & Frameworks > Illuminated Cloud >  Salesfroce DX tab
    ```
    Increase the width of the dialog window and click folder Icon then system will find path to SFDX automatically. Or you can set this path manually.

4) Setup auto push to Scratch:
    ```
    File > Settings > Languages & Frameworks > Illuminated Cloud >  Salesfroce DX tab
    ```
    In section "Automatically push to server on" select "Save" and "Delete"

5) Turn off using tabs characters in code:
    ```
    File > Settings > Editor > Code Style > Apex > Uncheck "Use tab character"
    ```

6) Setup file headers:
    ```
    File > Settings > Editor > File and Code Templates >  Tab "Includes" > Apex File Header
    ```
    
    Add text for a header with your name like:
    
    ```
    /**
     * (Write a succinct description of this class here. You should avoid
     * wordiness and redundancy. If necessary, additional paragraphs should
     * be preceded by <p>, the html tag for a new paragraph.)
     *
     * @author: Ivanov Ivan
     * @date: ${DATE}
     * 
     */   
    ```
   
7) Show toolbar:
    ```
    View > Appearance > Toolbar
    ```
   