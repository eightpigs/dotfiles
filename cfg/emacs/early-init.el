(if (eq system-type 'darwin)
  (setq url-proxy-services
    '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
      ("http" . "127.0.0.1:8890")
      ("https" . "127.0.0.1:8890")))

  (setenv "LIBRARY_PATH" "/usr/local/opt/gcc/lib/gcc/10:/usr/local/opt/libgccjit/lib/gcc/10:/usr/local/opt/gcc/lib/gcc/10/gcc/x86_64-apple-darwin20/10.2.0")
)


