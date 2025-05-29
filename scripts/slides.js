import { SfeirThemeInitializer } from "../web_modules/sfeir-school-theme/sfeir-school-theme.mjs";

// One method per module
function schoolSlides() {
  return [
    "00_Intro.md",
    "02_Speaker.md",
    "03_40m.md",
    "05_Contexte.md",
    "07_Conformite.md",
    "10_Retour_sur_k8s.md",
    "11_Register_Controller.md",
    "20_Histoire_Admission.md",
    "30_Kyverno.md",
    "34_Exemple_verify_image.md",
    "40_Policy_reporter.md",
    "60_Conclusions.md",
    "99_Questions.md",
    "50_Demos.md"
  ];
}

function formation() {
  return [
    //
    ...schoolSlides(),
  ].map((slidePath) => {
    return { path: slidePath };
  });
}

await SfeirThemeInitializer.init(formation);
