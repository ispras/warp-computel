version 1.0


task Bowtie2Align {
  input {
    File fastq_r1_gzipped_input
    File fastq_r2_gzipped_input
    String output_sam_basename
    Array[File] bowtie2_index_files
    String bowtie2_index_basename
    Int cores
    String docker
  }
  
  String index_basename = basename(bowtie2_index_files[0], ".1.bt2")

  command <<< 
      set -o pipefail
      set -e
      cat ~{fastq_r1_gzipped_input} ~{fastq_r2_gzipped_input} | gunzip -  | tee >(wc -l > length_log.txt) | bowtie2-align -q --end-to-end --quiet -p ~{cores} --phred33 --no-unal --n-ceil 64 -D 20 -R 3 -N 1 -L 22 -i S,1,0.5 -x $(dirname ~{bowtie2_index_files[0]})/~{index_basename} -U -  -S ~{output_sam_basename}.sam
    >>>
  runtime {
    docker: docker
  }
  output {
    File output_sam = "~{output_sam_basename}.sam"
  }

}
