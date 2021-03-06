context("crm_plain")

url <- "https://api.elsevier.com/content/article/PII:S0370269310012608?httpAccept=text/plain"
title <- "On the unitarity of linearized General Relativity coupled to matter"

if (identical(Sys.getenv("NOT_CRAN"), "true")) {
  vcr::use_cassette("crm_plain_prep", {
    link1 <- crm_links("10.1016/j.physletb.2010.10.049", "plain")
    link2 <- crm_links("10.1016/j.scib.2017.04.011", "plain")
  })
}

test_that("crm_plain works with links input",{
  skip_on_cran()
  skip_on_ci()

  # vcr::use_cassette("crm_plain_links_in", {
  res <- suppressMessages(crm_plain(link1))
  # }, preserve_exact_body_bytes = TRUE)
  expect_is(res, "character")
  expect_length(res, 6)
  expect_gt(nchar(paste0(res, collapse = "")), 100000L)
  expect_true(any(grepl(title, res)))
})

test_that("crm_plain works with links input, another eg", {
  skip_on_cran()
  skip_on_ci()

  # vcr::use_cassette("crm_plain_elsevier", {
  res <- suppressMessages(crm_plain(link2))
  # }, preserve_exact_body_bytes = TRUE)
  expect_is(res, "character")
  expect_length(res, 8)
  expect_gt(nchar(paste0(res, collapse = "")), 100L)
})

# FIXME: this doesn't quite work, 
# test_that("crm_plain works with character URL input", {
#   skip_on_cran()
#   res <- suppressMessages(crm_plain(url))
#   expect_is(res, "character")
#   expect_gt(nchar(res), 100L)
#   expect_match(res, title)
# })

test_that("crm_plain fails well",{
  skip_on_cran()
  
  expect_error(crm_plain(5), "no 'crm_plain' method for numeric")
  expect_error(crm_plain(mtcars), "no 'crm_plain' method for data.frame")
  expect_error(crm_plain(matrix(1:5)), "no 'crm_plain' method for matrix")
  expect_error(crm_plain("adfdf"), "Not a proper url")
  expect_error(crm_plain(link1, overwrite_unspecified = 5),
               "overwrite_unspecified must be of class logical")
})
