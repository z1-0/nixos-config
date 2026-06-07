{
  lib,
  python3Packages,
  fetchurl,
}: let
  tavily-python = python3Packages.buildPythonPackage rec {
    pname = "tavily-python";
    version = "0.7.26";
    format = "wheel";

    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/1b/c2/616ebcd49561d74c93099efa45fd5a4af2e528415f01351575980be0ba9e/tavily_python-${version}-py3-none-any.whl";
      hash = "sha256-m55/LRCzVyRE4T6aO/T1NBl11ZHLwTBr4E74mjY+Qqc==";
    };

    propagatedBuildInputs = with python3Packages; [
      requests
      tiktoken
      httpx
    ];

    pythonImportsCheck = ["tavily"];
    doCheck = false;

    meta = with lib; {
      description = "Python wrapper for the Tavily API";
      homepage = "https://github.com/tavily-ai/tavily-python";
      license = licenses.mit;
      platforms = platforms.all;
      maintainers = [];
    };
  };

  tavily-cli = python3Packages.buildPythonApplication rec {
    pname = "tavily-cli";
    version = "0.1.4";
    format = "wheel";

    src = fetchurl {
      url = "https://files.pythonhosted.org/packages/67/05/7cfeac06daba7c028b5a92a426910a1da68995db072b4c483a1800488962/tavily_cli-${version}-py3-none-any.whl";
      hash = "sha256-74A3EMGxVsBYx94hoAc4B6gYNb5JZkX2ZQTT4m5RC9k==";
    };

    propagatedBuildInputs = with python3Packages; [
      tavily-python
      click
      rich
      httpx
      requests
      urllib3
      certifi
    ];

    pythonImportsCheck = ["tavily_cli"];
    doCheck = false;

    meta = with lib; {
      description = "CLI and agent tools for the Tavily API";
      homepage = "https://github.com/tavily-ai/tavily_cli";
      license = licenses.mit;
      mainProgram = "tvly";
      platforms = platforms.all;
      maintainers = [];
    };
  };
in
  tavily-cli
