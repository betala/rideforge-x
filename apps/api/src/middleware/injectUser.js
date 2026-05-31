export function injectUser(req, _res, next) {
  const authorization = req.header('authorization');

  // Replace this with Firebase Auth or your identity provider verification.
  req.user = {
    id: authorization?.replace('Bearer ', '') || 'dev-user',
  };

  next();
}

