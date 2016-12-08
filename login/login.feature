TODO:
Login is performed with mail address and password against SSO - or cached with salted bcrypt.
All requests/responses are transferred over https.
On authentication the session id is changed, specifically for the site.
On re-authentication the session id is changed, and other sessions of the same user are invalidated.
One session id can only be used from the same IP; sent as HttpOnly with Strict-Transport-Security.
On logout or 10min inactivity timeout the session id is invalidated.
Users not logged in are always redirected to the login page.
Logged in users can only access the defined pages, but especially no directory browsing, svn subdirectories,...
Login failures are logged (without session id or password) and require some delay before the next attempt from the same IP.
During maintenance (after outage) only executive/supervisory board members and moderators shall have access.