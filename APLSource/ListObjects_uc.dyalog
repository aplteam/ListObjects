:Namespace  ListObjects_uc
⍝ This user command lists all objects in the current or any given namespace.\\
⍝ With the options `-nc` and `-l` one can suppress or enhance the result.\\
⍝ The project lives on GitHub: <https://github.com/aplteam/ListObjects>\\
⍝ Kai Jaeger

    ⎕io←1 ⋄ ⎕ml←1

    CR←⎕UCS 13

    ∇ r←List
      r←⎕NS''
      r.Name←'ListObjects'
      r.Desc←'Prints names, name class and type of all objects in a given namespace'
      r.Group←'APLTree'
      r.Parse←'1s -nc= -begin= -find= -local -stats -version'    ⍝ 0 to 2 arguments, some optional switches
    ∇

    ∇ r←Run(Cmd Args);nc;execIn;locals;version;stats;find;begin
      version←¯1 Args.Switch'version'
      stats←¯1 Args.Switch'stats'
      find←''Args.Switch'find'
      begin←''Args.Switch'begin'
      :If ¯1≠version
          r←⍕⎕SE.ListObjects.Version
      :Else
          :If 0=≢Args.Arguments
              execIn←(⎕SI⍳⊂'UCMD')⊃⎕RSI
          :Else
              execIn←1⊃,Args.Arguments
              :If 9=⎕NC execIn
                  execIn←⍎execIn
              :Else
                  execIn←{('⎕#'∊⍨⊃⍵):⍵ ⋄ ⍵,⍨'.',⍨(⎕SI⍳⊂'UCMD')⊃⎕NSI}execIn
                  :If ((⊂'⎕SE')∊'⎕SE' '⎕se')∨9=⎕NC execIn
                      execIn←⍎execIn
                  :Else
                      6 ⎕SIGNAL⍨'Value Error: "',execIn,'"'
                  :EndIf
              :EndIf
          :EndIf
          :If 0≡nc←Args.Switch'nc'
              nc←⍳16
          :Else
              nc←{⊃⊃(//)⎕VFI ⍵}¨','(≠⊆⊢)⍕nc
          :EndIf
          locals←0 Args.Switch'local'
          r←⎕SE.ListObjects.Run execIn locals nc
          :If 0<≢begin
              r⌿⍨←(⎕C(⊂⍴begin)↑¨r[;2])≡¨⊂⎕C begin
          :EndIf
          :If 0<≢find
              r←(∨/(⎕C find)⍷⎕C↑r[;2])⌿r
          :EndIf
          :If ¯1≢stats
              r←{⍺,(≢⍵)}⌸r[;1 3]
              r⍪←'' 'Total:'(+/r[;3])
              r←2 1⍴((⎕PW-2)↑'--- Statistics for ',(⍕execIn),' ',⎕PW⍴'-')r
          :Else
              r←(⍉↑↓¨'⎕NC' 'Name' 'Type'⍪[0.5]¨'=')⍪r
              r[⍸r[;3]≡¨⊂'Instance';3]←⊂'Class Instance'
              r←2 1⍴((⎕PW-2)↑'--- ',((⍕¯2+≢r),' hit',(((0≠¯2+≢r)∨3<≢r)/'s'),' in ',⍕execIn),' ',⎕PW⍴'-')r
          :EndIf
      :EndIf
    ∇

    ∇ r←level Help Cmd;from
      r←''
      :Select level
      :Case 0
          r,←⊂''
      :Case 1
          r,←⊂'Lists all APL objects found in the namespace the command'
          r,←⊂'was called from OR the namespace specified as the (optional) argument.'
          r,←⊂''
          r,←⊂'Options and flags:'
          r,←⊂' -begin=  : Return objects that begin with... (NOT case sensitive)"'
          r,←⊂' -find=   : Return objects that carry the given text somewhere (NOT case sensitive)'
          r,←⊂' -nc=     : Restrict output to the given name class(es). Single number or a comma-separated'
          r,←⊂'            list of number'
          r,←⊂' -local   : By default all local names are supressed. Change this by specifying -local'
          r,←⊂' -stats   : Prints statistics: how many names of certain classes where found.'
          r,←⊂' -version : Prints version information to the session. If specified everything else is ignored.'
          r,←⊂''
          r,←⊂'For examples enter:'
          r,←⊂']ListObjects -???'
      :Case 2
          r,←⊂'Examples:'
          r,←⊂''
          r,←⊂' ]ListObjects'
          r,←⊂' ]ListObjects #.CertainNamespace'
          r,←⊂' ]ListObjects -nc=2,3.2,4'
          r,←⊂' ]ListObjects -begin=BeginsWith'
          r,←⊂' ]ListObjects #.CertainNamespace -nc=3.1 -begin=S -local'
          r,←⊂' ]ListObjects #.CertainNamespace -find=anywhere'
          r,←⊂' ]ListObjects #.CertainNamespace -find=anywhere -stats'
          r,←⊂' ]ListObjects -stats'
          r,←⊂' ]ListObjects -version'
      :EndSelect
    ∇

:EndNamespace
