{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,

  # build-system
  poetry-core,

  # dependencies
  django,

  # optionals
  bleach,
  docutils,
  markdown,
  pygments,
  python-creole,
  smartypants,
  textile,

  # tests
  pytest-cov-stub,
  pytest-django,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "django-markup";
  version = "1.9.1";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "bartTC";
    repo = "django-markup";
    tag = "v${version}";
    hash = "sha256-dj5Z36W4Stly203SKWpR/DF+Wf7+ejbZnDCmHNRb3c0=";
  };

  build-system = [ poetry-core ];

  dependencies = [ django ];

  optional-dependencies = {
    all_filter_dependencies = [
      bleach
      docutils
      markdown
      pygments
      python-creole
      smartypants
      textile
    ];
  };

  pythonImportsCheck = [ "django_markup" ];

  nativeCheckInputs = [
    pytest-cov-stub
    pytest-django
    pytestCheckHook
  ]
  ++ optional-dependencies.all_filter_dependencies;

  disabledTests = [
    # pygments compat issue
    "test_rst_with_pygments"
  ];

  preCheck = ''
    export DJANGO_SETTINGS_MODULE=django_markup.tests
  '';

  meta = with lib; {
    description = "Generic Django application to convert text with specific markup to html";
    homepage = "https://github.com/bartTC/django-markup";
    changelog = "https://github.com/bartTC/django-markup/blob/v${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ hexa ];
  };
}
