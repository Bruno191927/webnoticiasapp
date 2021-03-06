import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListaNoticias extends StatelessWidget {
  final List<Article> noticias;

  const ListaNoticias(this.noticias);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 20),
      itemCount: this.noticias.length,
      itemBuilder: (BuildContext context, int index) {
      return _Noticia(noticia: this.noticias[index],index: index,);
     },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia(
    {
      @required this.noticia, 
      @required this.index
    }
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(noticia,index),
        _TarjetaTitulo(noticia),
        _TarjetaImagen(noticia),
        _TarjetaBody(noticia),
        _TarjetaBotones(),
        SizedBox(height: 10,),
        Divider()
      ],
    );
  }
}

 class _TarjetaBody extends StatelessWidget {
   final Article noticia;

  const _TarjetaBody(this.noticia);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text((noticia.description != null)?noticia.description : ''),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title,style:TextStyle(fontSize:20,fontWeight: FontWeight.w700)),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth>1000){
          return _image(height: 300);
        }
        else{
          return _image(height: 200);
        }
      },
    );
  }

  Widget _image({double height}){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
        child: Container(
          height: height,
          width: double.infinity,
          child: (noticia.urlToImage != null)
          ?FadeInImage(
            fit: BoxFit.fill,
            placeholder: AssetImage('assets/img/giphy.gif'),
            image: NetworkImage(noticia.urlToImage),
          )
          :Image(
            fit: BoxFit.fill,
            image: AssetImage('assets/img/no-image.png')
          )
        ),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int indice;
  const _TarjetaTopBar(this.noticia,this.indice);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${noticia.source.name}')
        ],
      ),
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: (){

            },
            fillColor: miTema.accentColor,
            child: Icon(Icons.star_border),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(width: 20,),
          RawMaterialButton(
            onPressed: (){

            },
            fillColor: Colors.blue,
            child: Icon(Icons.more),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    );
  }
}