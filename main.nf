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

revision = grabRevision()
version = '0.17.0523'

switch (params) {
  case {params.help} :
    helpMessage(version, revision)
    exit 1

  case {params.version} :
    versionMessage(version, revision)
    exit 1
}

tex = []

params.tex.each {tex << file(it)}

sideTex = Channel.fromPath( "$params.sideTex" )
sideTex = sideTex.flatten().toList()

biblio = file("$params.biblio")

pictures = file(params.pictures)
startMessage(version, revision)

/*
================================================================================
=                                 P R O C E S S                                =
================================================================================
*/

process CompileCV {
  tag {cv}
  publishDir ".", mode: 'move'

  input:
  file cv from tex
  file pictures
  file sideTex
  file biblio

  output:
  file("*.pdf") into pdf

  script:
  """
  xelatex ${cv.baseName}.tex
  biber ${cv.baseName}.bcf
  xelatex ${cv.baseName}.tex
  xelatex ${cv.baseName}.tex
  """
}

/*
================================================================================
=                               F U N C T I O N S                              =
================================================================================
*/

def grabRevision() {
  return workflow.revision ?: workflow.scriptId.substring(0,10)
}

def helpMessage(version, revision) {
  log.info "myCV compiler ~ $version - revision: $revision"
  log.info "    Usage:"
  log.info "       nextflow run MaxUlysse/myCV [--tex <input.tex>]"
  log.info "    --help"
  log.info "       you're reading it"
  log.info "    --tex"
  log.info "       compile input tex file"
  log.info "    --version"
  log.info "       displays version number"
}


def startMessage(version, revision) {
  log.info "myCV compiler ~ $version - revision: $revision"
  log.info "Command line: $workflow.commandLine"
  log.info "Project Dir : $workflow.projectDir"
  log.info "Launch Dir  : $workflow.launchDir"
  log.info "Work Dir    : $workflow.workDir"
}

def versionMessage(version, revision) {
  log.info "myCV compiler"
  log.info "  version $version"
  if (workflow.commitId) {
  	log.info "Git info    : $workflow.repository - $workflow.revision [$workflow.commitId]"
  } else {
  	log.info "  revision  : $revision"
  }
  log.info "Project   : $workflow.projectDir"
  log.info "Directory : $workflow.launchDir"
}

workflow.onComplete {
  log.info "N E X T F L O W ~ $workflow.nextflow.version - $workflow.nextflow.build"
  log.info "myCV compiler ~ $version - revision: $revision"
  log.info "Command line: $workflow.commandLine"
  log.info "Project Dir : $workflow.projectDir"
  log.info "Launch Dir  : $workflow.launchDir"
  log.info "Work Dir    : $workflow.workDir"
  log.info "Completed at: $workflow.complete"
  log.info "Duration    : $workflow.duration"
  log.info "Success     : $workflow.success"
  log.info "Exit status : $workflow.exitStatus"
  log.info "Error report:" + (workflow.errorReport ?: '-')
}

workflow.onError {
  log.info "myCV compiler"
  log.info "Workflow execution stopped with the following message: $workflow.errorMessage"
}
