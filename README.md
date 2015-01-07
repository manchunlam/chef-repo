# `knife-solo` and `berkshelf`

## Table of Contents

1. [Introduction](i-introduction)
2. [Declare gem dependencies](ii-declare-gem-dependencies)

## I. Introduction

Using `knife-solo` to generate a cookbook structure, and `berkshelf` to
declare cookbook dependencies.

## II. Initiate a Kitchen

1. Declare gem dependencies

    ```sh
    mkdir chef-repo
    bundle init
    ```

    Add the following gems to the `Gemfile`

    1. `chef` (`~> 11.6.4` unless you have Ruby 2.0)
    2. `knife-solo`
    3. `berkshelf`

2. Create a kitchen

    ```sh
    bundle exec knife solo init .
    ```

3. Create a **site** cookbook

    A **site** cookbook is cookbook tailored to your instance. As opposed to
    cookbooks that are available (e.g. `nginx`, `apache2`, etc)

    ```sh
    bundle exec knife cookbook create -o site-cookbooks/ vps
    ```

    Your custom cookbook `vps` is now under the `site-cookbooks` directory.

4. Add cookbook dependencies for **all** your site-cookbooks

    See [Berksfile](Berksfile).

5. Tell the `vps` cookbook what it depends on

    See [site-cookbooks/vps/metadata.rb](site-cookbooks/vps/metadata.rb)

    **Note**

    Do **not** put platform-specific dependencies here (e.g. `yum`, `apt`, etc)

6. Tell the `vps` cookbook to do something by writing a `recipe`

    See [site-cookbooks/vps/recipes/default.rb](site-cookbooks/vps/recipes/default.rb).

    You can have multiple recipes (`*.rb) in the
    [`recipes`](site-cookbooks/vps/recipes) directory.

    You can include those in the _default_ by

    ```ruby
    # site-cookbooks/vps/recipes/default.rb

    include_recipes 'vps::foobar'
    ```

7. Create a JSON to tell `knife-solo` how to provision your box

    See [nodes/vps.json](nodes/vps.json)

    All the recipes listed in the JSON **must** be in `Berksfile`.

7. Provision your box!

    ```sh
    bundle exec knife solo bootstrap foo@example.com nodes/vps.json -V
    ```

    * `-V` verbose

8. Clean up afterwards

    During provisioning `knife-solo` copied quite a bit of data onto the remote
    instance.

    To remove those

    ```sh
    bundle exec knife solo clean foo@example.com
    ```

    **Note**

    It **does not** revert the system changes
