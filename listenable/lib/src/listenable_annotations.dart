/// Use this annotation to mark a class for which you want to listen changes.
class ListenableModel {
  const ListenableModel();
}

/// Use this annotation to mark a field for which you want to listen changes.
/// The Field should belong to a class annotated with [ListenableModel].
class ListenableProperty {

  /// This option indicates if a change event should be fired in the model that contains this property.
  /// It is enabled by default.
  final bool updatesModel;

  /// By default change event will be fired only if there is value change, using == operator, in the property value,
  /// with this option you can make that every time a value is assigned to the property a change event if fired.
  /// Use this property to force change events on mutable containers like ([List],[Set],[Map])
  /// It is disabled by default.
  final bool alwaysFireChangeEvent;

  const ListenableProperty({this.updatesModel = true, this.alwaysFireChangeEvent=false});
}