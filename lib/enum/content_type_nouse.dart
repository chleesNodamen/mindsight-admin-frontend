// enum ContentType {
//   // ContentCategory.body
//   basicBody('Basic Body', 'BASIC_BODY'),
//   intermediateBody('Intermediate Body', 'INTERMEDIATE_BODY'),
//   advanceBody('Advanced Body', 'ADVANCE_BODY'),

//   // ContentCategory.breath
//   natureBreathing('Natural Breathing', 'NATURE_BREATHING'),
//   guidedMeditation('Meditation Guide', 'GUIDED_MEDITATION'),

//   // ContentCategory.mindfulness
//   mindfulArt('Mindfulness Art', 'MINDFUL_ART'),
//   artWithMusic('Art with Music', 'ART_WITH_MUSIC'),
//   nature('Nature', 'NATURE'),
//   kAsmr('K-ASMR', 'K_ASMR'),

//   // ContentCategory.theory
//   emotionManagement('Emotion Management', 'EMOTION_MANAGEMENT'),
//   philosophy('Philosophy', 'PHILOSOPHY'),
//   selfDevelopment('Self-development', 'SELF_DEVELOPMENT');

//   final String _displayName;
//   final String _keywordName;

//   const ContentType(this._displayName, this._keywordName);

//   String get displayName => _displayName;
//   String get keywordName => _keywordName;

//   static ContentType? fromKeyword(String value) {
//     for (var type in ContentType.values) {
//       if (type.keywordName == value) {
//         return type;
//       }
//     }
//     return null;
//   }
// }
