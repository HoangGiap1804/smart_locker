class ItemModel {
  String pathImage;
  String nameItem;
  String discribe;
  int price;
  int oldPrice;
  int sellOff;
  int numOfStar;

  ItemModel({
    required this.pathImage,
    required this.nameItem,
    required this.discribe,
    required this.price,
    required this.oldPrice,
    required this.sellOff,
    required this.numOfStar,
  });

  static List<ItemModel> getListItem (){
    List<ItemModel> list = [];

    list.add(
      ItemModel(
        pathImage: "assets/images/items/item1.jpg", 
        nameItem: "Item1 2AV", 
        discribe: "Neque porro quisquam est qui dolorem ipsum quia", 
        price: 1800, 
        oldPrice: 4000, 
        sellOff: 30, 
        numOfStar: 4)
    );
    list.add(
      ItemModel(
        pathImage: "assets/images/items/item1.jpg", 
        nameItem: "Item1 2AV", 
        discribe: "Neque porro quisquam est qui dolorem ipsum quia", 
        price: 1800, 
        oldPrice: 4000, 
        sellOff: 30, 
        numOfStar: 4)
    );
    list.add(
      ItemModel(
        pathImage: "assets/images/items/item3.jpg", 
        nameItem: "Item1 2AV", 
        discribe: "Neque porro quisquam est qui dolorem ipsum quia", 
        price: 1800, 
        oldPrice: 4000, 
        sellOff: 30, 
        numOfStar: 4)
    );
    list.add(
      ItemModel(
        pathImage: "assets/images/items/item1.jpg", 
        nameItem: "Item1 2AV", 
        discribe: "Neque porro quisquam est qui dolorem ipsum quia", 
        price: 1800, 
        oldPrice: 4000, 
        sellOff: 30, 
        numOfStar: 4)
    );
    list.add(
      ItemModel(
        pathImage: "assets/images/items/item1.jpg", 
        nameItem: "Item1 2AV", 
        discribe: "Neque porro quisquam est qui dolorem ipsum quia", 
        price: 1800, 
        oldPrice: 4000, 
        sellOff: 30, 
        numOfStar: 4)
    );
    list.add(
      ItemModel(
        pathImage: "assets/images/items/item1.jpg", 
        nameItem: "Item1 2AV", 
        discribe: "Neque porro quisquam est qui dolorem ipsum quia", 
        price: 1800, 
        oldPrice: 4000, 
        sellOff: 30, 
        numOfStar: 4)
    );

    return list;
  }
}
