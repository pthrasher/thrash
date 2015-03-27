# The below lines are here for reference.   Do not uncomment these.
# -----------------------------------------------------------------
# Max per process = 524,288 (512 * 1024)
# Max total       = 1,048,576 (1024 * 1024)

# echo 'limit maxfiles 524288 1048576' | sudo tee -a /etc/launchd.conf
# echo kern.maxfilesperproc=524288 | sudo tee -a /etc/sysctl.conf
# echo kern.maxfiles=1048576 | sudo tee -a /etc/sysctl.conf

# sudo sysctl -w kern.maxfilesperproc=524288
# ┗━ kern.maxfilesperproc: 10240 -> 524288

# sudo sysctl -w kern.maxfiles=1048576
# ┗━ kern.maxfiles: 12288 -> 1048576

# also review this: https://github.com/basho/basho_docs/issues/1402
# ----------------------end reference------------------------------


# important -- must actually run every time the shell opens.
ulimit -n 524288

