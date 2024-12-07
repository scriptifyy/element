require(script.Parent).start({
	permissions = {
		[255] = game.CreatorId; --// add your own ids here.
	};

	group_id = 0 --// if you have a group, it's permissions will be transfered over if not keep this at 0
});