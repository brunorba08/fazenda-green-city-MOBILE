import 'package:flutter/material.dart';

void main() {
  runApp(GreenCityApp());
}

class GreenCityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GreenCity',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green[50],
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/cart': (context) => CartPage(),
        '/login': (context) => LoginPage(),
        '/favorites': (context) => FavoritesPage(),
        '/delivery': (context) => DeliveryPage(),
        '/payment': (context) => PaymentPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('APP/assets/produtos/logo.png', height: 20),
            SizedBox(width: 5),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar produtos...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.mic),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () => Navigator.pushNamed(context, '/register'),
          ),
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () => Navigator.pushNamed(context, '/login'),
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Bem-vindo à Fazenda GreenCity! Confira nossas melhores otas!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600
                    ? 3
                    : 2, // Ajusta a quantidade de colunas
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: 'Produto ${index + 1}',
                  price: 'R\$ ${(index + 1) * 10},00',
                  image: 'APP/assets/produtos/alface.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          productName: 'Produto ${index + 1}',
                          productPrice: 'R\$ ${(index + 1) * 10},00',
                          productImage:
                              'APP\assets\produtos\alface${index + 1}.',
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final Function onTap;

  ProductCard({
    required this.name,
    required this.price,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 80),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              price,
              style: TextStyle(color: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsPage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String productImage;

  ProductDetailsPage({
    required this.productName,
    required this.productPrice,
    required this.productImage,
  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productName),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: [
            Image.asset(widget.productImage, height: 200),
            SizedBox(height: 10),
            Text(
              widget.productName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              widget.productPrice,
              style: TextStyle(color: Colors.green[700], fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
                'Quantidade mínima: ${widget.productName.contains("kg") ? "10 kg" : "15 unidades"}'),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed:
                      quantity > (widget.productName.contains("kg") ? 10 : 15)
                          ? () {
                              setState(() {
                                quantity--;
                              });
                            }
                          : null,
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica para o carrinho.
                // Exemplo: Adicionar o item ao carrinho

                // Agora mostramos a mensagem de sucesso com o SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item adicionado com sucesso!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Adicionar ao Carrinho'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Página de login
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width *
                0.05), // Removido o ponto e vírgula
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica de login
              },
              child: Text('Entrar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Cadastro
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isEmailOffersChecked = false;
  bool isSmsOffersChecked = false;
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width *
                0.05), // Removido o ponto e vírgula
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome Fantasia',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nome Social',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'CNPJ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: isEmailOffersChecked,
                    onChanged: (value) {
                      setState(() {
                        isEmailOffersChecked = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text('Aceito receber ofertas por Email'),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isSmsOffersChecked,
                    onChanged: (value) {
                      setState(() {
                        isSmsOffersChecked = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text('Aceito receber ofertas por SMS'),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: isTermsAccepted,
                    onChanged: (value) {
                      setState(() {
                        isTermsAccepted = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text('Aceito os Termos e Condições'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isTermsAccepted
                    ? () {
                        Navigator.pushNamed(context, '/login');
                      }
                    : null,
                child: Text('Cadastrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Exemplo de carrinho
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: Text('Seu carrinho está vazio'),
      ),
    );
  }
}

// Página de favoritos
class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: Text('Seus produtos favoritos'),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagamento'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Escolha o método de pagamento',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Cartão de Crédito/Débito'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Lógica para processar pagamento com cartão
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.pix),
              title: Text('Pix'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Lógica para processar pagamento com Pix
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.picture_as_pdf),
              title: Text('Boleto Bancário'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Lógica para gerar boleto
              },
            ),
            Divider(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Finalizar pagamento e transação
              },
              child: Text('Finalizar Pagamento'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  String selectedDeliveryMethod = 'Padrão (5-7 dias úteis)';
  String address = 'Rua Exemplo, 123, Bairro, Cidade, Estado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrega'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding corrigido
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Endereço de entrega
            Text(
              'Escolha o endereço de entrega',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green[50],
                border: Border.all(color: Colors.green[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Endereço atual:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(address),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Lógica para editar o endereço
                    },
                    child: Text('Editar endereço',
                        style: TextStyle(color: Colors.green[700])),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            // Método de entrega
            Text(
              'Escolha o método de entrega',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text('Padrão (5-7 dias úteis)'),
              trailing: Radio<String>(
                value: 'Padrão (5-7 dias úteis)',
                groupValue: selectedDeliveryMethod,
                onChanged: (value) {
                  setState(() {
                    selectedDeliveryMethod = value!;
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.local_shipping),
              title: Text('Expresso (1-3 dias úteis)'),
              trailing: Radio<String>(
                value: 'Expresso (1-3 dias úteis)',
                groupValue: selectedDeliveryMethod,
                onChanged: (value) {
                  setState(() {
                    selectedDeliveryMethod = value!;
                  });
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.directions_car),
              title: Text('Retirada no local'),
              trailing: Radio<String>(
                value: 'Retirada no local',
                groupValue: selectedDeliveryMethod,
                onChanged: (value) {
                  setState(() {
                    selectedDeliveryMethod = value!;
                  });
                },
              ),
            ),
            Spacer(),
            // Botão de confirmação
            ElevatedButton(
              onPressed: () {
                // Confirmar o pedido com o endereço e método de entrega escolhidos
              },
              child: Text('Confirmar Entrega'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
