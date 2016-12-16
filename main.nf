#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
=====================
=  COMPILE - BEAMER =
=====================
*/

revision = grabGitRevision() ?: ''
version = 'v0.16.1216'

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
=====================
=     PROCESSES     =
=====================
*/

process CompileAltaCV {
  publishDir ".", mode: 'move'

  input:
  file ('myAltaCVen.tex')
  file ('myAltaCVfr.tex')
  file pictures

  output:
  file("*.pdf") into altaCVpdf

  script:
  """
  xelatex myAltaCVen.tex
  xelatex myAltaCVen.tex
  xelatex myAltaCVfr.tex
  xelatex myAltaCVfr.tex
  """
}

process CompileModernCV {
  publishDir ".", mode: 'move'

  input:
  file ('myModernCVen.tex')
  file ('myModernCVfr.tex')
  file pictures

  output:
  file("*.pdf") into modernCVpdf

  script:
  """
  xelatex myModernCVen.tex
  xelatex myModernCVen.tex
  xelatex myModernCVfr.tex
  xelatex myModernCVfr.tex
  """
}

/*
=====================
=     FUNCTIONS     =
=====================
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
	log.info "       nextflow run MaxUlysse/myCV --tex <input.tex> --theme <modernCV||altaCV>"
	log.info "    --help"
	log.info "       you're reading it"
	log.info "    --version"
	log.info "       displays version number"
}

def startMessage(version, revision) {
	log.info "myCV compiler ~ $version - revision: $revision"
	log.info "Project     : $workflow.projectDir"
	log.info "Directory   : $workflow.launchDir"
	log.info "workDir     : $workflow.workDir"
	log.info "Command line: $workflow.commandLine"
}

def versionMessage(version, revision) {
	log.info "myCV compiler"
	log.info "  version $version"
	log.info "  revision: $revision"
	log.info "Git info  : repository - $revision [$workflow.commitId]"
	log.info "Project   : $workflow.projectDir"
	log.info "Directory : $workflow.launchDir"
}

workflow.onComplete {
	log.info "myCV compiler ~ $version - revision: $revision"
	log.info "Project     : $workflow.projectDir"
	log.info "workDir     : $workflow.workDir"
	log.info "Command line: $workflow.commandLine"
	log.info "Completed at: $workflow.complete"
	log.info "Duration    : $workflow.duration"
	log.info "Success     : $workflow.success"
	log.info "Exit status : $workflow.exitStatus"
	log.info "Error report: ${workflow.errorReport ?: '-'}"
}

workflow.onError {
	log.info "myCV compiler"
	log.info "Workflow execution stopped with the following message: $workflow.errorMessage"
}
