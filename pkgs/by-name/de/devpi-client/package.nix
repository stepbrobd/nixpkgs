{
  lib,
  devpi-server,
  git,
  glibcLocales,
  python3,
  fetchPypi,
  nix-update-script,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "devpi-client";
  version = "7.2.0";
  pyproject = true;

  src = fetchPypi {
    pname = "devpi-client";
    inherit version;
    hash = "sha256-wUM2hFjDh4unvuah2bQY4uZZVxo4VmFPWNdriigmnXs=";
  };

  build-system = with python3.pkgs; [
    setuptools
    setuptools-changelog-shortener
  ];

  buildInputs = [ glibcLocales ];

  dependencies = with python3.pkgs; [
    build
    check-manifest
    devpi-common
    iniconfig
    pkginfo
    pluggy
    platformdirs
  ];

  nativeCheckInputs = [
    devpi-server
    git
  ]
  ++ (with python3.pkgs; [
    mercurial
    mock
    pypitoken
    pytestCheckHook
    sphinx
    virtualenv
    webtest
    wheel
  ]);

  preCheck = ''
    export HOME=$(mktemp -d);
  '';

  pytestFlags = [
    # --fast skips tests which try to start a devpi-server improperly
    "--fast"
  ];

  LC_ALL = "en_US.UTF-8";

  __darwinAllowLocalNetworking = true;

  pythonImportsCheck = [ "devpi" ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Client for devpi, a pypi index server and packaging meta tool";
    homepage = "http://doc.devpi.net";
    changelog = "https://github.com/devpi/devpi/blob/client-${version}/client/CHANGELOG";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [
      lewo
      makefu
    ];
    mainProgram = "devpi";
  };
}
