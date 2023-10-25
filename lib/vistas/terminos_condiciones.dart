import 'package:flutter/material.dart';

class TerminosCondiciones extends StatefulWidget {
  const TerminosCondiciones({super.key});

  @override
  State<TerminosCondiciones> createState() => _TerminosCondicionesState();
}

class _TerminosCondicionesState extends State<TerminosCondiciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF854),
        title: const Text(
          'Términos y condiciones',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.format_align_right_outlined),
          ),
        ],
      ),
      body: _terminosCondiciones(),
    );
  }
}

Widget _terminosCondiciones() {
  String content =
      'Digital solution se reserva el derecho de monitorear todos los comentarios y eliminar los que puedan considerarse inapropiados, ofensivos o que incumplan estos Términos y Condiciones. Garantizas y declaras que: Tienes derecho a publicar comentarios en nuestro sitio web y tienes todas las licencias y consentimientos necesarios para hacerlo; Los comentarios no invaden ningún derecho de propiedad intelectual, incluidos, entre otros, los derechos de autor, patentes o marcas comerciales de terceros; Los comentarios no contienen ningún material difamatorio, calumnioso, ofensivo, indecente o ilegal de otro modo, que sea una invasión de la privacidad. Los comentarios no se utilizarán para solicitar o promover negocios o actividades comerciales personalizadas o presentes o actividades ilegales. Por la presente, otorgas a Digital solution una licencia no exclusiva para usar, reproducir, editar y autorizar a otros a usar, reproducir y editar cualquiera de tus comentarios en todas y cada una de las formas, formatos, o medios. Hipervínculos a nuestro contenido: Las siguientes organizaciones pueden vincularse a nuestro sitio web sin aprobación previa por escrito: Agencias gubernamentales; Motores de búsqueda; Organizaciones de noticias; Los distribuidores de directorios en línea pueden vincularse a nuestro sitio web de la misma manera que hacen hipervínculos a los sitios web de otras empresas que figuran en la lista; y Empresas acreditadas en todo el sistema, excepto que soliciten organizaciones sin fines de lucro, centros comerciales de caridad y grupos de recaudación de fondos de caridad que no pueden hacer hipervínculos a nuestro sitio web. Estas organizaciones pueden enlazar a nuestra página de inicio, a publicaciones o a otra información del sitio siempre que el enlace: (a) no sea engañoso de ninguna manera; (b) no implique falsamente patrocinio, respaldo o aprobación de la parte vinculante y sus productos y/o servicios; y (c) encaja en el contexto del sitio de la parte vinculante. Podemos considerar y aprobar otras solicitudes de enlaces de los siguientes tipos de organizaciones';

  return SingleChildScrollView(
    child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '¿Qué es Perfect Connection?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'PerfectConection es una plataforma innovadora diseñada para potenciar y promover negocios locales, centrándose particularmente en el sector alimenticio (restaurantes, reto-bares, cocinas económicas, fondas, entre otros). Nuestra misión es brindar visibilidad a aquellos emprendedores que, debido a la falta de experiencia o recursos, encuentran desafiantes diseñar campañas publicitarias efectivas para sus establecimientos.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Estos términos y condiciones describen las reglas y regulaciones para el uso del sitio web de Digital solution, ubicado en perfectconnection.com'),
            const Text('Licencia:'),
            const Text(
                'A menos que se indique lo contrario, Digital solution y/o sus licenciantes poseen los derechos de propiedad intelectual de todo el material en Perfect Connection. Todos los derechos de propiedad intelectual son reservados. Puedes acceder desde Perfect Connection para tu uso personal sujeto a las restricciones establecidas en estos términos y condiciones.'),
            const Text('No debes: '),
            const Text(
                'Copiar o volver a publicar material de Perfect Connection Vender, alquilar o sublicenciar material de Perfect Connection Reproducir, duplicar o copiar material de Perfect Connection Redistribuir contenido de Perfect Connection Este acuerdo comenzará el fecha presente.'),
            const Text(
                'Partes de esta aplicación móvil ofrecen a los usuarios la oportunidad de publicar e intercambiar opiniones e información en determinadas áreas. Digital solution no filtra, edita, publica ni revisa los comentarios antes de su presencia en el sitio web. Los comentarios no reflejan los puntos de vista ni las opiniones de Digital solution, sus agentes y/o afiliados. Los comentarios reflejan los puntos de vista y opiniones de la persona que publica. En la medida en que lo permitan las leyes aplicables, Digital solution no será responsable de los comentarios ni de ninguna responsabilidad, daños o gastos causados ​​o sufridos como resultado de cualquier uso o publicación o apariencia de comentarios en este sitio web.'),
            Text(content),
          ],
        )),
  );
}
