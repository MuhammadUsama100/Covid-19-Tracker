final List<CardViewModel> demoCards = [
 
  new CardViewModel(
    backdropAssetPath: 'assets/2_ff.jpg',
    name: 'Muhammad Usama',
    email: 'usamamuhammad833@gmail.com',
    //position: 'Mobile App Developer',
  ),
  new CardViewModel(
    backdropAssetPath: 'assets/5_ff.jpg',
    name: 'Mohammad Areeb',
    email: 'mohammadareebs@gmail.com',
    //position: 'Mobile App Developer',
  ),
  new CardViewModel(
    backdropAssetPath: 'assets/6_ff.jpg',
    name: 'Mehdi Raza Rajani',
    email: 'Mehdiraza572@gmail.com',
    //position: 'Project Head',
  ),
  
];

class CardViewModel {
  final String backdropAssetPath;
  final String name;
  final String email;
  //final String position;

  CardViewModel({this.backdropAssetPath, this.name, this.email});
}
