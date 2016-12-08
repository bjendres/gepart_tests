TODO:
On authentication the session id is changed.
On re-authentication the session id is changed, and other sessions of the same user are invalidated.
The session can only be used for the same IP.
Users not logged in are always redirected to the login page.
Logged in users can only access the defined pages, but especially no directory browsing, svn subdirectories,...
