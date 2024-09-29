class DialogRequest{

  final String? title;
  final String? subTitle;
  final String? description;
  final String? positiveLabel;
  final String? negativeLabel;
  final String? cancelLabel;
  final bool? isAlertByVisit;

  DialogRequest({
    this.title,
    this.subTitle,
    this.description,
    this.positiveLabel,
    this.negativeLabel,
    this.cancelLabel,
    this.isAlertByVisit
  });
}