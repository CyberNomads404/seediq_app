<div align="center">

# 📱 SeedIQ App — Aplicativo Mobile

Aplicativo mobile para operadores em campo. Captura imagens de grãos, envia para análise automática e exibe os resultados de classificação em segundos. Parte do ecossistema SeedIQ.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-00B4D8?style=flat&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=flat&logo=android&logoColor=white)

</div>

---

## 📸 Preview

| Login | Nova Análise | Histórico |
|-------|-------------|-----------|
| <img width="510" height="1022" alt="Captura de tela de 2025-11-26 14-34-22" src="https://github.com/user-attachments/assets/5bcf5486-fcd7-4d71-95b5-eafd2fbc6a15" /> | <img width="510" height="1022" alt="Captura de tela de 2025-11-26 15-07-48" src="https://github.com/user-attachments/assets/cd5dddb1-2409-488c-a2c9-8bdd36969457" /> | !<img width="510" height="1022" alt="Captura de tela de 2025-11-26 15-07-58 (1)" src="https://github.com/user-attachments/assets/2d12d1ec-1efe-44c9-8f26-a386013cfd52" /> |

| Resultado da Classificação | Perfil |
|---------------------------|--------|
| <img width="510" height="1022" alt="Captura de tela de 2025-11-26 15-08-02" src="https://github.com/user-attachments/assets/45845e57-ec7a-48ac-add5-39fd5ad82c4f" /> | <img width="510" height="1022" alt="Captura de tela de 2025-11-26 15-08-06" src="https://github.com/user-attachments/assets/e4a4b958-1b56-4d20-b041-63af9a3a2cf5" /> |

---

## 📌 Sobre o projeto

O SeedIQ é um projeto acadêmico desenvolvido no último semestre do curso de Sistemas de Informação (2025.2), integrando três disciplinas: Programação para Dispositivos Móveis, Segurança e Auditoria de Sistemas e Computação Gráfica e Processamento de Imagens.

Este repositório contém o **App Mobile**, a ferramenta do operador em campo. O fluxo é simples: o operador tira uma foto dos grãos, seleciona o tipo, e em segundos recebe a contagem de grãos bons, queimados, esverdeados e pequenos diretamente na tela.

O ecossistema completo é dividido em três repositórios:

| Parte | Repositório | Descrição |
|-------|-------------|-----------|
| 🖥️ Painel + API Central | [SeedIQ](https://github.com/CyberNomads404/SeedIQ) | Gestão, dashboard e orquestração |
| 🔬 API de Classificação | [SeedIQ-AI](https://github.com/CyberNomads404/SeedIQ-AI) | Visão computacional com Python + OpenCV |
| 📱 App Mobile | este repositório | App Flutter para operadores em campo |

---

## 🔁 Fluxo de funcionamento

<img width="1471" height="904" alt="Diagrama Caso de Uso drawio" src="https://github.com/user-attachments/assets/0eb331be-96ef-4548-9836-87e4614504d8" />

1. Operador faz login com autenticação via token + Refresh Token
2. Captura ou seleciona uma foto dos grãos pelo image_picker
3. Seleciona o tipo de grão e envia para a API Central via Dio
4. API Central processa e enfileira o job para a API de Classificação
5. Resultado aparece na tela com contagem por categoria e percentuais

---

## 🏗️ Arquitetura

O app segue o padrão **MVC** com gerenciamento de estado via **Riverpod**, o que garante separação clara de responsabilidades e facilita a escalabilidade:

```
lib/
├── models/          # Modelos de dados (Classification, User, etc.)
├── views/           # Telas e widgets da interface
│   ├── pages/       # Páginas principais (Login, Home, Histórico, Perfil)
│   └── widgets/     # Componentes reutilizáveis
├── controllers/     # Lógica de negócio e providers Riverpod
└── services/        # Comunicação com a API (Dio)
```

---

## 📦 Principais dependências

| Pacote | Versão | Uso |
|--------|--------|-----|
| `flutter_riverpod` | ^3.0.3 | Gerenciamento de estado |
| `riverpod_annotation` | ^3.0.3 | Geração de código para providers |
| `dio` | ^5.9.0 | Requisições HTTP para a API |
| `flutter_secure_storage` | ^9.2.4 | Armazenamento seguro de tokens |
| `image_picker` | ^1.2.0 | Captura e seleção de imagens |
| `flutter_svg` | ^2.0.7 | Renderização de ícones SVG |
| `envied` | ^1.3.1 | Variáveis de ambiente seguras |
| `validatorless` | ^1.2.5 | Validação de formulários |
| `top_snackbar_flutter` | ^3.3.0 | Notificações visuais |
| `loading_animation_widget` | ^1.3.0 | Animações de carregamento |
| `intl` | ^0.20.2 | Formatação de datas |
| `url_launcher` | ^6.3.2 | Abertura de links externos |

---

## 🔒 Segurança

- Autenticação com **JWT + Refresh Token** para manter a sessão sem expor credenciais
- Tokens armazenados com **flutter_secure_storage**, usando o Keystore no Android e Keychain no iOS
- Variáveis de ambiente protegidas com **envied**, evitando exposição de chaves no código
- Comunicação com a API exclusivamente via **HTTPS**

---

## 🚀 Rodando localmente

Pré-requisitos: Flutter SDK ^3.9.2 e Dart instalados

```bash
# 1. Clonar o repositório
git clone https://github.com/CyberNomads404/seediq_app.git
cd seediq_app

# 2. Instalar dependências
flutter pub get

# 3. Copiar e configurar o .env
cp .env.example .env
# Edite o .env com a URL da API Central

# 4. Gerar código do Riverpod e Envied
dart run build_runner build --delete-conflicting-outputs

# 5. Rodar o app
flutter run
```

---

## 👥 Equipe

Desenvolvido pela equipe **CyberNomads404** como Projeto Integrador do curso de Sistemas de Informação — 2025.2

- [@Erikli999](https://github.com/Erikli999) – Erikli999
- [@piedro404](https://github.com/piedro404) – Pedro Henrique Martins Borges
- [@thayna-bezerra](https://github.com/thayna-bezerra) – Thayna Bezerra

---

## 📬 Contato

pedro.henrique.martins404@gmail.com
