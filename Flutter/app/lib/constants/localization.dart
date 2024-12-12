import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_UK': {
          'calibration': 'Calibration',
          'tutorial':
              'The Calibration function allows you to calibrate your face by looking in the indicated area for a few seconds',
          'calibrationCompleted': 'Calibration completed successfully.',
          'error01': 'Calibration error, repeat calibration for the zone!',
          'settings': 'Settings',
          'italian': 'Italian',
          'english': 'English',
          'changeLanguage': 'Change Language',
          'diagnostics': 'Diagnostics',
          'data': 'Data',
          'placeholder':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse condimentum feugiat sollicitudin.',
          'placeholderSmall': 'Lorem ipsum',
          'detect': 'Detect Face',
        },
        'it_IT': {
          'calibration': 'Calibrazione',
          'tutorial':
              'La funzione di Calibrazione permette di calibrare il viso guardando nella zona indicata per qualche secondo.',
          'calibrationCompleted':
              'La Calibrazione è stata completata correttamente.',
          'error01':
              'Errore nella calibrazione, ripeti la calibrazione per la zona!',
          'settings': 'Impostazioni',
          'italian': 'Italiano',
          'english': 'Inglese',
          'changeLanguage': 'Cambia Lingua',
          'diagnostics': 'Diagnostica',
          'data': 'Dati',
          'placeholder':
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse condimentum feugiat sollicitudin.',
          'placeholderSmall': 'Lorem ipsum',
          'detect': 'Rileva Viso',
        }
      };
}
