# Rota Rehberi

Rota Rehberi uygulaması, kullanıcıların seyahat rotalarını oluşturmasına ve yönetmesine yardımcı olan bir mobil uygulamadır. Uygulamanın özellikleri arasında haritalar üzerinde rota oluşturma, rota listesi görüntüleme, konaklama yerlerini gözden geçirme ve rota hakkında detaylı bilgilere erişim bulunmaktadır.

## Özellikler

- Haritalar üzerinde rota oluşturma ve düzenleme
- Oluşturulan rotaların listesini görüntüleme
- Konaklama yerlerini harita üzerinde görüntüleme
- Rotalar hakkında detaylı bilgilere erişim

## Kullanılan Teknolojiler

- **Flutter:** Uygulama, Google'ın Flutter framework'ü kullanılarak geliştirilmiştir. Flutter, tek bir kod tabanıyla Android ve iOS platformlarına hızlı ve kolay bir şekilde uygulama geliştirme imkanı sağlar.
- **Firebase:** Kullanıcı kimlik doğrulama işlemleri ve veritabanı yönetimi için Firebase kullanılmıştır. Firebase Authentication ile kullanıcıların giriş yapması ve veritabanı işlemleri için Firebase Firestore kullanılmıştır.

## Gereksinimler

- Flutter SDK: Uygulama Flutter framework'ü kullanılarak geliştirildiği için Flutter SDK'nın yüklü olması gerekmektedir.
- Firebase Projesi: Uygulamanın Firebase Authentication ve Firestore servislerini kullanabilmesi için bir Firebase projesi oluşturulmalı ve gerekli konfigürasyonlar yapılmış olmalıdır.

## Kurulum

1. Proje dosyalarını indirin veya klonlayın.
2. Terminali açın ve proje dizinine gidin.
3. `flutter pub get` komutunu çalıştırarak bağımlılıkları yükleyin.
4. Firebase projesi oluşturun ve Firebase SDK konfigürasyonlarını projeye entegre edin.
5. Uygulamayı bir cihazda çalıştırın veya emülatörde çalıştırın.

## Flutter Version

Uygulama Flutter 3.16.8 sürümü ile geliştirilmiştir. Flutter SDK'nın yüklü olduğundan ve güncel olduğundan emin olun.

## Kullanılan Paketler

- cupertino_icons: ^1.0.2
- flutter_osm_plugin: ^0.70.4
- firebase_core: ^2.27.0
- firebase_auth: ^4.17.8
- image_picker: ^1.0.7
- cloud_firestore: ^4.15.8
- flutter_svg: ^2.0.10+1

## Firebase Bağlantısı

Uygulama Firebase Authentication ve Firestore servislerini kullanmaktadır. Firebase projesi oluşturduktan sonra, Firebase SDK konfigürasyonlarını projeye entegre ederek bu servisleri kullanabilirsiniz.
