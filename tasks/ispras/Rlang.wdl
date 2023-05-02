version 1.0

task RlangComputel {
  input {
    File bamfile
    File coverage_file
    File rscript_main
    File rscript_functions
    String tel_length_txt
    String tel_variants_txt
    String docker 
  }

  command <<<
      Rscript ~{rscript_main} ~{rscript_functions} ~{coverage_file} ~{bamfile} ~{tel_length_txt} ~{tel_variants_txt}
    >>>
  runtime {
    docker: docker 
  }


  output {
    File tel_length_txt_file = tel_length_txt
    File tel_variants_txt_file = tel_variants_txt
  }
}
