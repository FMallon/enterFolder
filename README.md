Old script I use a lot, so i will make public!
Allows user to enter a folder based on a partial string (case sensitive)
It does not work for dot folders though.

User will have to create the alias in their .bashrc &/or .zshrc file.  I set mine to "enter".

E.g. in ~/ I have Documents, Programs, Downloads....  
By entering "enter Doc", it will automatically enter Documents.  
By entering "enter Do", a list appears: 
  
  1) Documents
  2) Downloads

Entering the corresponding number into the CLI will direct the user to that Folder.

By entering "enter .", a list will appear of all folders, and user can enter the corresponding number.

So yeh... to use, download the file, then add an alias directed to the file in your .bashrc/.zshrc file, and it should be fine.  There is no other features other than its intended use-case.  It was a quick script that I developed because I was using WSL and my Folder names were big, and complicated on my Windows 10.  
