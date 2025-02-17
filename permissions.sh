# Reset directory permissions to 755 (rwx for owner, rx for group/others)
find /home/pawel -type d -exec chmod 755 {} \;

# Reset file permissions to 644 (rw for owner, r for group/others)
find /home/pawel -type f -exec chmod 644 {} \;

# Set specific permissions for .ssh (if it exists)
chmod 700 /home/pawel/.ssh
chmod 600 /home/pawel/.ssh/*

