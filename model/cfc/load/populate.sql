INSERT INTO roles
    (name, level)
VALUES
    ('Superuser', 1),
    ('Admin', 2),
    ('General', 3);


INSERT INTO users (
    firstname,lastname, email, lastlogin, password, salt, status, resetlockout, notificationExlude, roleid)
VALUES
    ('Test', 'User', 'none@none.net', NULL, '478BCE3561732858F8A9EF45307EB336240A49DE8A82E1F1D7A154B1F91BD0A6832D0A5399301C284DA5EAE2410AC98B9568589EEFFD72C500349FF01D3EE257', 'CDE5AC0C755C99DDDCD236DAE9A4A4F4B02C1736CFA7A5332D4B46F2B9E17774F5A8AF382F0AFBD45FD4E37EFEC3A9EF726A192E3D6AE924D40D4BF1A9618625', 1, 0, 0, 1);


INSERT INTO tournament (
    created, updated, tournamentname, eventdate, registrationstart, registrationend, registrationkey, adminkey, allowlate, details, userid
)
VALUES
(NULL, NULL, 'Test Tournament', NULL, NULL, NULL, NULL, NULL, 0, NULL, 1);



INSERT INTO player (
    created, updated, gamername, email, discord, twitter, twitch, platform, streaming, rank, level, tournamentid, teamid)
VALUES
(NULL, NULL, 'Player 1', 'none@none.net', NULL, NULL, NULL, 'PC', 1, NULL, NULL,  1, null),
(NULL, NULL, 'Player 2', 'none@none.net', NULL, NULL, NULL, 'XBOX', 1, NULL, NULL, 1, null);


INSERT INTO team 
    (created, updated, name, status, tournamentid)
VALUES
(NULL, NULL, 'Team 1', 1, 1),
(NULL, NULL, 'Team 2', 1, 1);


update player set teamid = 1 where id = 1;
update player set teamid = 2 where id = 2;

