version 1.0

import "../../../tasks/ispras/Bowtie2.wdl" as Bowtie2
import "../../../tasks/ispras/Samtools.wdl" as Samtools
import "../../../tasks/ispras/Rlang.wdl" as Rlang

# WORKFLOW DEFINITION
workflow Computel {

  input {
    Map[String, String] docker
    File fastq_r1_gzipped_input
    File fastq_r2_gzipped_input
    File reference
    Array[File] bowtie2_index_files
    String bowtie2_index_basename 
    Int cores
    File rscript_main
    File rscript_functions
    String tel_length_txt
    String tel_variants_txt
    String output_basename
  }


  call Bowtie2.Bowtie2Align {
    input:
      fastq_r1_gzipped_input = fastq_r1_gzipped_input,
      fastq_r2_gzipped_input = fastq_r2_gzipped_input,
      output_sam_basename = output_basename,
      bowtie2_index_files = bowtie2_index_files,
      bowtie2_index_basename = bowtie2_index_basename,
      cores = cores,
      docker = docker["bowtie2"]
  }

  call Samtools.SamtoolsView{
    input:
      samfile = Bowtie2Align.output_sam,
      output_bam_basename = output_basename,
      docker = docker["samtools"]
  }

  call Samtools.SamtoolsSort{
    input:
      bamfile = SamtoolsView.output_bam,
      output_bam_basename = output_basename,
      docker = docker["samtools"]
  }

  call Samtools.SamtoolsDepth{
    input:
      bamfile = SamtoolsSort.output_bam,
      output_bam_basename = output_basename,
      docker = docker["samtools"]
  }

  call Rlang.RlangComputel{
    input:
      bamfile = Bowtie2Align.output_sam,
      coverage_file = SamtoolsDepth.output_cov_file,
      rscript_main = rscript_main,
      rscript_functions = rscript_functions,
      tel_length_txt = tel_length_txt,
      tel_variants_txt = tel_variants_txt,
      docker = docker["rlang_computel"]
  }


  output{
    File tel_length_txt_file = RlangComputel.tel_length_txt_file
    File tel_variants_txt_file = RlangComputel.tel_variants_txt_file
  }
}
