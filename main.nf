params.greeting = "Hello World!"
greeting_ch = Channel.of(params.greeting) 

process SPLITLETTERS { 
    input: 
    val x 

    output: 
    path 'annotate_*' 

    script: 
    """
    printf '$x' | split -b 6 - annotate_
    """
} 

process CONVERTTOUPPER { 
    input: 
    path y 

    output: 
    stdout 

    script: 
    """
    rev $y | tr '[a-z]' '[A-Z]'
    """
} 

workflow {
    letters_ch = SPLITLETTERS(greeting_ch) 
    results_ch = CONVERTTOUPPER(letters_ch.flatten()) 
    results_ch.view { it } 
} 
