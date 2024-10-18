
# Deploy Meltdown with Grav Headless CMS

[Meltdown](https://meltdown.dex.yachts) + [Grav](https://getgrav.org)

```sh
git clone https://github.com/the-syndrome/meltdown-with-grav.git
cd meltdown-with-grav
git clone https://github.com/the-syndrome/meltdown.git app
cp .env.example .env
docker-compose up
cp grav/mgadmin.yaml config/www/user/accounts/mgadmin.yaml
```

By default these services will be up but there are no collections or pages in it yet.

+ grav <http://127.0.0.1:33764/admin> login with details in `./grav/mgadmin.yaml`
+ meltdown <http://127.0.0.1:33765>

Copy grav pages to meltdown pages. ⚠️ Destination files will be overwritten.

```sh
rm app/src/pages/index.imba
npm install --ignore-scripts
npm rebuild esbuild
npm run copy-pages
```

Test

+ <http://127.0.0.1:33765>
+ <http://127.0.0.1:33765/typography>

## Next steps

### Edit pages

Grav has a flexible editor with many options and plugins to explore.

<http://127.0.0.1:33764/admin/pages>

### Configure Meltdown

If you like this combination of Grav+Meltdown you might want to customize Meltdown's [environment](https://meltdown.dex.yachts/deploy/environment) variables. Some developers might want to generate a fully static site with [SSG](https://meltdown.dex.yachts/features/ssg).

### Configure Grav

Grav has many [config options](https://learn.getgrav.org/17/basics/grav-configuration) and plugins to explore.

+ Your enabled plugins <http://127.0.0.1:33764/admin/plugins>
+ Available plugins <http://127.0.0.1:33764/admin/plugins/install>


GPM Grav Package Manager CLI

```sh
docker-compose exec -w /app/www/public grav /app/www/public/bin/gpm
```

## Troubleshooting

### Admin redirects to 127.0.0.1/

It may be confused because it's in a container.

Edit `./config/www/user/config/system.yaml`

Add line:

```yaml
custom_base_url: http://127.0.0.1:33764
```

### Permission denied copying

The containers sometimes change the file permissions so that the user cannot access the files in `./config`.

```sh
sudo cp grav/mgadmin.yaml config/www/user/accounts/mgadmin.yaml
```

### Reach out for help

Join the [Community](https://meltdown.dex.yachts/community)