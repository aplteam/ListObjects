# ListObjects

## Overview

`]ListObjects` lists all objects in the current namespace: functions, operators, classes, interfaces, namespaces, namespace scripts, interfaces, class instances, GUI instances and references.


## Installation

`]ListObjects` can be installed as a Tatin package:

```
]Tatin.InstallPackages [tatin]ListObjects [MyUCMDs]
```

This will make the user commands of `]ListObjects` available.

Note that `]ListObjects` does not offer an API.


## Examples

```
      ]ListObjects
 --- 50 hits in #.FilesAndDirs.FilesAndDirs ---
 ⎕NC  Name                Type                 
 ===  ====                ====                 
 2.1  ADOC_Doc            Vars                 
 9.1  API                 Namespace            
 9.4  APLTreeUtils2       Ref to Class         
 3.1  AddTrailingSep      Traditional Function 
 3.1  Cd                  Traditional Function 
 3.1  CheckPath           Traditional Function 
 3.1  CurrentSep          Traditional Function 
 3.1  DateToReal          Traditional Function 
 3.1  DeleteFile          Traditional Function 
 3.1  Dir                 Traditional Function 
 ...
      ]ListObjects -s=Get
 --- 8 hits in #.FilesAndDirs.FilesAndDirs ---
 ⎕NC  Name                Type                 
 ===  ====                ====                 
 3.1  GetLastError        Traditional Function 
 3.1  GetModifiedDate     Traditional Function 
 3.1  GetMsgFromError     Traditional Function 
 3.1  GetNewLineCharsFor  Traditional Function 
 3.1  GetTempFilename     Traditional Function 
 3.1  GetTempFilename2    Traditional Function 
 3.1  GetTempPath         Traditional Function
 3.1  GetTempSubDir       Traditional Function   
      ]ListObjects -nc=3.2
 --- 1 hit in #.FilesAndDirs.FilesAndDirs ---
 ⎕NC  Name          Type            
 ===  ====          ====            
 3.2  EncodeBlanks  Direct Function 
      ]ListObjects -??
───────────────────────────────────────────────────────────────────────────────
]APLTREE.ListObjects

Lists all APL objects found in the namespace the command
was called from ''or'' the namespace specified as the (optional) argument.
                                                                         
Options and flags:
 -s=  : List objects that start their names with...
 -nc= : name class
 -l   : By default all localyzed names are supressed. Change with -l

Examples:
 ]ListObjects
 ]ListObjects #.CertainNamespace
 ]ListObjects -nc=3
 ]ListObjects -s=StartWith
 ]ListObjects #.CertainNamespace -nc=3.1 -s=S -l
```
