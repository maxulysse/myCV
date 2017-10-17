#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
================================================================================
=                     m  y  C  V     c  o  m  p  i  l  e  r                    =
================================================================================
@Author
Maxime Garcia <max@ithake.eu> [@MaxUlysse]
--------------------------------------------------------------------------------
 @Homepage
 https://github.com/MaxUlysse/myCV
--------------------------------------------------------------------------------
 @Documentation
 https://github.com/MaxUlysse/myCV/blob/master/README.md
--------------------------------------------------------------------------------
@Licence
 https://github.com/MaxUlysse/myCV/blob/master/LICENSE
--------------------------------------------------------------------------------
 Processes overview
 - RunXelatex - Run xelatex twice on given tex file
================================================================================
=                           C O N F I G U R A T I O N                          =
================================================================================
*/

if (!nextflow.version.matches('>= 0.25.3')) exit 1, "Nextflow version 0.25.3 or greater is needed to run this workflow"

version = '1.0'

params.help = false
params.version = false

if (params.help) exit 0, helpMessage()
if (params.version) exit 0, versionMessage()

params.biblio = 'biblio.bib'
biblio = file(params.biblio)

params.pictures = 'pictures'
pictures = file(params.pictures)

if (!params.tex) exit 1, 'No tex file, see --help for more information'
tex = file(params.tex)


/*
================================================================================
=                                 P R O C E S S                                =
================================================================================
*/

startMessage()

process CompileCV {
  tag {cv}
  publishDir ".", mode: 'move'

  input:
  file cv from tex
  file pictures
  file biblio

  output:
  file("*.pdf") into pdf

  script:
  """
  xelatex ${cv.baseName}.tex
  biber ${cv.baseName}.bcf
  xelatex ${cv.baseName}.tex
  xelatex ${cv.baseName}.tex
  cp ${cv.baseName}.pdf CV-MGarcia-latest.pdf
  """
}

/*
================================================================================
=                               F U N C T I O N S                              =
================================================================================
*/

def grabRevision() {
  // Return the same string executed from github or not
  return workflow.revision ?: workflow.commitId ?: workflow.scriptId.substring(0,10)
}

def helpMessage() {
  // Display help message
  this.myCVmessage()
  log.info "    Usage:"
  log.info "      nextflow run MaxUlysse/myCV [--tex <input.tex>]"
  log.info "    --tex"
  log.info "      Compile the given tex file"
  log.info "    --pictures"
  log.info "      Specify in which directory are the pictures"
  log.info "      Default is: pictures/"
  log.info "    --biblio"
  log.info "      Specify the bibliography file"
  log.info "      Default is: biblio.bib"
  log.info "    --tag"
  log.info "      Specify with tag to use for the docker container"
  log.info "      Default is current version: $version"
  log.info "    --help"
  log.info "      You're reading it"
  log.info "    --version"
  log.info "      Displays version number"
}

def minimalInformationMessage() {
  // Minimal information message
  log.info "Command Line: $workflow.commandLine"
  log.info "Launch Dir  : $workflow.launchDir"
  log.info "Work Dir    : $workflow.workDir"
  log.info "Profile     : $workflow.profile"
  log.info "Container   : $workflow.container"
  log.info "Tex file    : $tex"
  log.info "Biblio      : $biblio"
  log.info "Pictures in : $pictures"
}

def myCVmessage() {
  // Display myCV compiler message
  log.info "myCV compiler ~ $version - " + this.grabRevision() + (workflow.commitId ? " [$workflow.commitId]" : "")
}

def nextflowMessage() {
  // Nextflow message (version + build)
  log.info "N E X T F L O W  ~  version $workflow.nextflow.version $workflow.nextflow.build"
}

def startMessage() {
  // Display start message
  this.myCVmessage()
  this.minimalInformationMessage()
}

def versionMessage() {
  // Display version message
  log.info "myCV compiler"
  log.info "  version $version"
  log.info workflow.commitId ? "Git info    : $workflow.repository - $workflow.revision [$workflow.commitId]" : "  revision  : " + this.grabRevision()
}

workflow.onComplete {
  // Display end message
  this.nextflowMessage()
  this.myCVmessage()
  this.minimalInformationMessage()
  log.info "Completed at: $workflow.complete"
  log.info "Duration    : $workflow.duration"
  log.info "Success     : $workflow.success"
  log.info "Exit status : $workflow.exitStatus"
  log.info "Error report: " + (workflow.errorReport ?: '-')
}

workflow.onError {
  // Display error message
  this.nextflowMessage()
  this.myCVmessage()
  log.info "Workflow execution stopped with the following message: $workflow.errorMessage"
}
