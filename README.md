# Book Finder

Este é um aplicativo simples de busca de livros construído com Flutter e o padrão de arquitetura Bloc. Ele permite que os usuários pesquisem livros, visualizem detalhes dos livros encontrados e marquem livros como favoritos.

## Funcionalidades

O aplicativo possui as seguintes funcionalidades:

- Pesquisa de livros: Os usuários podem digitar palavras-chave na barra de pesquisa para buscar livros.
- Listagem de livros: Os resultados da pesquisa são exibidos em uma lista.
- Detalhes do livro: Os usuários podem ver os detalhes completos do livro, incluindo o autor e descrição.

## Arquitetura

O aplicativo segue o padrão de arquitetura Bloc (Business Logic Component).

As principais classes e suas responsabilidades são as seguintes:

- `BookFinderBloc`: É responsável por gerenciar o estado da busca de livros. Ele faz a chamada à API de busca, armazena os livros favoritos e atualiza o estado de acordo.
- `BookFinderScreen`: É a tela principal do aplicativo. Exibe a barra de pesquisa e a lista de livros com base no estado atual fornecido pelo `BookFinderBloc`.
- `BookDetailsScreen`: É a tela de detalhes do livro. Exibe informações detalhadas sobre um livro específico e permite que os usuários acessem o link de compra, se disponível.
- `Book`: É a classe que representa um livro. Ela contém informações como ID, título, autores, descrição, link de compra e se é um livro favorito.
- `BookAdapter`: É um adaptador usado pelo Hive (banco de dados local) para serializar e desserializar objetos `Book` para armazenamento.

## Dependências

O aplicativo utiliza as seguintes dependências:

- `flutter_bloc`: Fornece as classes e métodos necessários para implementar a arquitetura Bloc.
- `hive_flutter`: Uma biblioteca de armazenamento local que permite armazenar os livros favoritos.
- `url_launcher`: Permite abrir links externos para compra de livros.
- `connectivity`: Verifica o estado da conectividade para determinar se deve exibir apenas os livros favoritos em vez de realizar a pesquisa online.

## Executando o aplicativo

Para executar o aplicativo, siga as etapas abaixo:

1. Certifique-se de ter o Flutter instalado em sua máquina. Você pode encontrar instruções de instalação em [flutter.dev](https://flutter.dev).
2. Clone o repositório do aplicativo Book Finder em sua máquina.
3. Abra um terminal na pasta raiz do projeto.
4. Execute o comando `flutter pub get` para instalar as dependências do projeto.
5. Conecte um dispositivo ou inicie um emulador.
6. Execute o comando `flutter run` para iniciar o aplicativo.

Isso iniciará o aplicativo Book Finder no dispositivo ou emulador selecionado.
