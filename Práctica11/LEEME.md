# Práctica Terraform y Cloudflare

Este proyecto crea un Worker que responde a GET en JSON y registra cada visita en una base D1. El subdominio habilita el Worker en workers.dev. Al destruir los recursos también se borra la base de datos y su contenido. Usa nombres nuevos y exclusivos para esta práctica; no apuntes a recursos existentes.

## Antes de empezar

1. Instala Terraform y abre una terminal nueva. Comprueba `terraform version`. Si no se reconoce, revisa la instalación y la variable PATH según https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli.
2. En Cloudflare, activa Workers y registra primero el subdominio de tu cuenta `workers.dev`, si aún no lo tienes. Anota ese subdominio. Esta configuración de cuenta es un requisito previo y el proyecto no la crea ni la destruye.
3. Obtén el Account ID y crea un token de API restringido a tu cuenta, con permisos de edición para Workers Scripts y D1. No compartas el token ni subas archivos de estado o credenciales.
4. Abre PowerShell en esta carpeta. Copia `terraform.tfvars.example` a `terraform.tfvars`, edítalo con tu Account ID y nombres nuevos, y guarda el archivo. Configura el token de forma privada en la sesión actual:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
notepad terraform.tfvars
$env:TF_VAR_api_token = Read-Host "Pega tu token de Cloudflare"
```

No envíes el token por chat. La terminal puede mostrar lo que escribes: protege tu pantalla y usa una sesión privada.

## Ejecución y evidencias

```powershell
terraform init
terraform fmt
terraform validate
terraform plan -out=practica.tfplan
```

Revisa que el plan vaya a crear solo los tres recursos de la práctica y toma una captura. Si propone modificar o destruir algo existente, detente y revisa los nombres y el estado. Los archivos de estado y el plan pueden contener información sensible.

```powershell
terraform apply practica.tfplan
```

Toma una captura del resultado. En el navegador abre `https://NOMBRE-DEL-WORKER.TU-SUBDOMINIO.workers.dev/`, sustituyendo los dos valores por los tuyos. Debe aparecer un JSON con `ok`, `mensaje`, `visitas` y `url`. Toma la captura antes de destruir el proyecto. Cada GET aumenta el contador.

Luego, desde la misma carpeta y conservando el estado, ejecuta:

```powershell
terraform destroy
```

Revisa el plan de destrucción y escribe `yes` solo si contiene los recursos de esta práctica. Toma una captura del resultado y comprueba en Cloudflare que ya no estén el Worker ni la base D1. Si una operación falla, no borres el archivo de estado: sirve para que Terraform identifique lo que falta eliminar. La eliminación de D1 es permanente.

Para retirar el token de la sesión actual: `Remove-Item Env:TF_VAR_api_token`.

La versión del proveedor se fijó en 5.8.2 para seguir la sintaxis del ejemplo de clase; ejecutar `terraform init` descarga esa versión. La configuración no se ha probado contra una cuenta real.
