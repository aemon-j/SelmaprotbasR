#'@title Run the GOTM-Selmaprotbas model
#'
#'@description
#'This runs the GOTM-Selmaprotbas model on the specific simulation stored in \code{sim_folder}.
#'
#'@param sim_folder the directory where simulation files are contained
#'@param yaml_file filepath; to file with GOTM setup. Defaults to "gotm.yaml"
#'@param verbose Save output as character vector. Defaults to FALSE
#'@param args Optional arguments to pass to GOTM executable
#'
#'@keywords methods
#'@author
#'Tadhg Moore, Jorrit Mesman
#'@examples
#'sim_folder <- system.file("extdata", package = "SelmaprotbasR")
#'run_gotm_sp(sim_folder)
#'@export
#'@importFrom utils packageName

run_gotm_sp <- function(sim_folder = ".", yaml_file = "gotm.yaml", verbose = FALSE, args = character()){
  
  if(.Platform$pkgType == "win.binary"){
    return(run_gotm_sp_Win(sim_folder, yaml_file = yaml_file, verbose, args))
  }

  ### macOS ###
  if(grepl("mac.binary", .Platform$pkgType)){
    maj_v_number <- as.numeric(strsplit(Sys.info()["release"][[1]], ".", fixed = TRUE)[[1]][1])

    if(maj_v_number < 13.0){
      stop("pre-mavericks mac OSX is not supported. Consider upgrading")
    }

    return(run_gotm_sp_OSx(sim_folder, verbose, args))

  }

  if(.Platform$pkgType == "source"){
    return(run_gotm_sp_NIX(sim_folder, verbose, args))
  }
}

run_gotm_sp_Win <- function(sim_folder, yaml_file = "gotm.yaml", verbose = TRUE, args){

  if(.Platform$r_arch == "x64"){
    gotm_path <- system.file("extbin/win64GOTM/gotm_sp.exe", package = "SelmaprotbasR")
  }else{
    stop("No GOTM-Selmaprotbas executable available for your machine yet...")
  }

  args <- c(args, yaml_file)

  origin <- getwd()
  setwd(sim_folder)

  tryCatch({
    if(verbose){
      out <- system2(gotm_path, wait = TRUE, stdout = TRUE,
                     stderr = "", args = args)
    }else{
      out <- system2(gotm_path, stdout = NULL,
                     stderr = NULL, args = args)
    }
    setwd(origin)
    return(out)
  }, error = function(err){
    print(paste("GOTM_ERROR:  ", err))
    setwd(origin)
  })
}

run_gotm_sp_NIX <- function(sim_folder, verbose = TRUE, args){
  origin <- getwd()
  setwd(sim_folder)
  gotm_path <- system.file("exec/nixgotm_sp", package="SelmaprotbasR")
  Sys.setenv(LD_LIBRARY_PATH = paste(system.file("extbin/nix",
                                                 package = "SelmaprotbasR"),
                                   Sys.getenv("LD_LIBRARY_PATH"), 
                                   sep = ":"))
  tryCatch({
    if(verbose){
      out <- system2(gotm_path, wait = TRUE, stdout = "",
                     stderr = "", args = args)
    }else{
      out <- system2(gotm_path, wait = TRUE, stdout = NULL,
                     stderr = NULL, args = args)
    }
    setwd(origin)
    return(out)
  }, error = function(err){
    print(paste("gotm_ERROR:  ", err))
    setwd(origin)
  })
  setwd(origin)
  return(out)
}

### From GLEON/gotm3r
gotm.systemcall <- function(sim_folder, gotm_path, verbose, system.args){
  origin <- getwd()
  setwd(sim_folder)

  tryCatch({
    if(verbose){
      out <- system2(gotm_path, wait = TRUE, stdout = "",
                     stderr = "", args = system.args)
    }else{
      out <- system2(gotm_path, wait = TRUE, stdout = NULL,
                     stderr = NULL, args = system.args)
    }
    setwd(origin)
    return(out)
  }, error = function(err){
    print(paste("gotm_ERROR:  ", err))
    setwd(origin)
  })
}

### macOS ###
run_gotm_sp_OSx <- function(sim_folder, verbose, args){
  gotm_path <- system.file("exec/macgotm_sp", package = "SelmaprotbasR")
  gotm.systemcall(sim_folder = sim_folder, gotm_path = gotm_path, verbose = verbose, system.args = args)
}
