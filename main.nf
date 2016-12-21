#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
================================================================================
=                     m  y  C  V     c  o  m  p  i  l  e  r                    =
================================================================================
@Author
Maxime Garcia <maxime.garcia@scilifelab.se> [@MaxUlysse]
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

revision = grabGitRevision() ?: ''
version = 'v0.16.1221'

tex = [
  file ('myModernCVen.tex'),
  file ('myModernCVfr.tex')
  // file ('myAltaCVen.tex'),
  // file ('myAltaCVfr.tex')
]

switch (params) {
  case {params.help} :
    helpMessage(version, revision)
    exit 1

  case {params.version} :
    versionMessage(version, revision)
    exit 1
}

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

  output:
  file("*.pdf") into pdf

  script:
  """
  xelatex ${cv}
  xelatex ${cv}
  """
}

/*
================================================================================
=                               F U N C T I O N S                              =
================================================================================
*/

def grabGitRevision() { // Borrowed from https://github.com/NBISweden/wgs-structvar
  if (workflow.commitId) { // it's run directly from github
    return workflow.commitId.substring(0,10)
  }
  // Try to find the revision directly from git
  headPointerFile = file("${baseDir}/.git/HEAD")
  if (!headPointerFile.exists()) {
    return ''
  }
  ref = headPointerFile.newReader().readLine().tokenize()[1]
  refFile = file("${baseDir}/.git/$ref")
  if (!refFile.exists()) {
    return ''
  }
  revision = refFile.newReader().readLine()
  return revision.substring(0,10)
}

def helpMessage(version, revision) {
  log.info "myCV compiler ~ $version - revision: $revision"
  log.info "    Usage:"
  log.info "       nextflow run MaxUlysse/myCV --tex <input.tex>"
  log.info "    --help"
  log.info "       you're reading it"
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
