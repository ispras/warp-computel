## Computel install
cd dockers/ispras/bowtie2

docker build -t bowtie2:2.1.0 .

cd dockers/ispras/samtools

docker build -t samtools:1.11 .

cd dockers/ispras/rlang_computel

docker build -t rlang_computel:3.6.3 .

cd pipelines/ispras/computel/

git submodule init

git submodule update

wget https://github.com/broadinstitute/cromwell/releases/download/85/cromwell-85.jar

## Computel run
sudo java -Dconfig.file=docker.conf -jar cromwell-85.jar run Computel.wdl --inputs Computel.inputs.json

## Computel results
cd cromwell-executions/Computel/RUN_ID/call-RlangComputel/execution

tel.variants.txt

tel.length.txt


## Extra info
The structure of the original warp repository from Broad Institute has been preserved for the compatibility of repositories with pipelines.
Computel version 1.2 code has been modified to be able to use other alignment algorithms in the future.

