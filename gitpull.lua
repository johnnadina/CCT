program=arg[1]
command = ("https://raw.githubusercontent.com/johnnadina/CCT/main/" .. program)
print("Downloading " .. program)
download = http.get(command) --This will make 'download' hold the contents of the file.
handle = download.readAll() --Reads everything in download
download.close() --remember to close download!

file = fs.open("homebase_alpha/" .. program,"w") --opens the file 'startup' with the permissions to write.
file.write(handle) --writes all the stuff in handle to the file 'startup'.
file.close() --remember to close download!