version 1.0


task SamtoolsView {
  input {
    File samfile
    String output_bam_basename
    String docker
  }
  
  command <<<
      samtools view -bSh ~{samfile} > ~{output_bam_basename}.bam
    >>>
  runtime {
    docker: docker
  }


  output {
    File output_bam = "~{output_bam_basename}.bam"
  }
}

task SamtoolsSort {
  input {
    File bamfile
    String output_bam_basename
    String docker
  }

  command <<<
      samtools sort ~{bamfile} -o ~{output_bam_basename}.bam_sorted
    >>>
  runtime { 
    docker: docker
  }

  
  output {
    File output_bam = "~{output_bam_basename}.bam_sorted"
  }
}

task SamtoolsDepth {
  input {
    File bamfile
    String output_bam_basename
    String docker
  }

  command <<<
      samtools depth -d 1000000000 ~{bamfile} > ~{output_bam_basename}.bam_sorted.coverage.txt
    >>>
  runtime {
    docker: docker
  }


  output {
    File output_cov_file = "~{output_bam_basename}.bam_sorted.coverage.txt"
  }

}
