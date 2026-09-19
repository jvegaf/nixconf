{ delib, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "th3g3ntl3man");
    gitUser = readOnly (strOption "Jose Vega");
    gitEmail = readOnly (strOption "josevega234@gmail.com");
  };
}
