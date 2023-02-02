abstract class FormStatus {
  const FormStatus();
}

class FormNotSent extends FormStatus {
  const FormNotSent();
}

class FormSubmitting extends FormStatus {
  const FormSubmitting();
}

class FormSubmissionFailed extends FormStatus {
  const FormSubmissionFailed();
}

class FormSubmissionSuccessful extends FormStatus {
  const FormSubmissionSuccessful();
}
