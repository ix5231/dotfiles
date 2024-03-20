; styled-component

((call_expression
   function: [
    ; styled.xxx
    (member_expression
     object: (identifier) @_name
      (#eq? @_name "styled"))
    ; styled(Comp)
    (call_expression
     function: (identifier) @_name
       (#eq? @_name "styled"))
    ; styled.xxx.attrs()
    (call_expression
      function: (member_expression
        object: (member_expression
          object: (identifier) @_name
            (#eq? @_name "styled"))))
    ; styled(Comp).attrs()
    (call_expression
      function: (member_expression
        object: (call_expression
          function: (identifier) @_name
            (#eq? @_name "styled"))))
   ]
   arguments: (template_string) @injection.content)
 (#set! injection.language "css"))

; createGlobalStyle

((call_expression
  function: (identifier) @_name
    (#eq? @_name "createGlobalStyle")
  arguments: (template_string) @injection.content)
 (#set! injection.language "css"))

; Parse the contents of tagged template literals using
; a language inferred from the tag.

(call_expression
  function: [
    (identifier) @injection.language
    (member_expression
      property: (property_identifier) @injection.language)
  ]
  arguments: (template_string) @injection.content)

; Parse the contents of gql template literals

((call_expression
   function: (identifier) @_template_function_name
   arguments: (template_string) @injection.content)
 (#eq? @_template_function_name "gql")
 (#set! injection.language "graphql"))

; Parse regex syntax within regex literals

((regex_pattern) @injection.content
 (#set! injection.language "regex"))

; Parse JSDoc annotations in multiline comments

((comment) @injection.content
 (#set! injection.language "jsdoc")
 (#match? @injection.content "^/\\*+"))

; Parse general tags in single line comments

((comment) @injection.content
 (#set! injection.language "comment")
 (#match? @injection.content "^//"))
